Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbUKITmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbUKITmf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 14:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbUKITme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 14:42:34 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:42738 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261644AbUKITlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 14:41:31 -0500
Message-ID: <41911D4F.5080606@nortelnetworks.com>
Date: Tue, 09 Nov 2004 13:41:03 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Blaisorblade <blaisorblade_spam@yahoo.it>
CC: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>,
       linux-kernel@vger.kernel.org, cw@f00f.org
Subject: Re: Synchronization primitives in UML
References: <200411052036.55541.blaisorblade_spam@yahoo.it> <200411091844.44218.blaisorblade_spam@yahoo.it> <200411092048.iA9Kmjg9004223@ccure.user-mode-linux.org> <200411092015.10544.blaisorblade_spam@yahoo.it>
In-Reply-To: <200411092015.10544.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Blaisorblade wrote:

> Yes, I would like that, too, but futexes are 2.6 only, and probably also 
> NPTL-only (we are going to fix that, at least for SKAS mode), but faster than 
> anything else. Nothing apart this.

Actually, you can use raw futexes directly without needing any thread library. 
There is even some helper code available if you search around a bit.

Chris
