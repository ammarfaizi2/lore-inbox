Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264286AbUHDLaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbUHDLaF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 07:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264298AbUHDLaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 07:30:05 -0400
Received: from tapuz.safe-mail.net ([212.68.149.115]:21985 "EHLO
	tapuz.safe-mail.net") by vger.kernel.org with ESMTP id S264286AbUHDLaC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 07:30:02 -0400
X-SMType: Regular
X-SMRef: N1-4kMCMCsv
Message-ID: <4110C8CB.1030108@safe-mail.net>
Date: Wed, 04 Aug 2004 19:30:19 +0800
From: Liu Tao <liutao@safe-mail.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: arjanv@redhat.com, lkml <linux-kernel@vger.kernel.org>,
       Oliver Neukum <oliver@neukum.org>
Subject: Re: [patch] Add a writer prior lock methord for rwlock
References: <4110A7AF.2060903@safe-mail.net> <1091610963.2792.13.camel@laptop.fenrus.com> <4110BA81.4030309@safe-mail.net> <20040804103337.GN2334@holomorphy.com>
In-Reply-To: <20040804103337.GN2334@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

>Unfortunately this will deadlock. read locks are acquired recursively.
>The algorithms dependent on this need to be redesigned.
>
>  
>

Thanks, it's not a feasible scheme since read locks are recursive.

Regards
