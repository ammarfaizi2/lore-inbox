Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270803AbTGPNQi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 09:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270807AbTGPNQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 09:16:38 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:9235 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S270803AbTGPNQh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 09:16:37 -0400
Message-ID: <3F155536.8090608@aitel.hist.no>
Date: Wed, 16 Jul 2003 15:37:58 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Antonio Vargas <wind@cocodriloo.com>
CC: Ingo Molnar <mingo@elte.hu>, Sean Neakums <sneakums@zork.net>,
       Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test1-mm1
References: <6uwueidhdd.fsf@zork.zork.net> <Pine.LNX.4.44.0307161052310.6193-100000@localhost.localdomain> <20030716101949.GE2684@wind.cocodriloo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonio Vargas wrote:
[...]
> It always happened to me when I run "make menuconfig" under gnome-terminal on
> redhat 9 with 2.5.73. Is it because of busy-waiting on a variable shared
> amongst multiple processes/threads? If so, it smells of a bug in the application,
> busy-waiting is _BAD_.

Ouch.  Well, it is good that scheduler changes made the bug visible,
so it can be fixed.  Certainly no reason to
work around it in the kernel, the effort is better spent on fixing
the bug.  Distributors can make sure they have fixed their apps
before distributing 2.6.

Helge Hafting

