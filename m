Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264299AbTKUFOt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 00:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264300AbTKUFOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 00:14:48 -0500
Received: from zero.aec.at ([193.170.194.10]:36868 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264299AbTKUFOs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 00:14:48 -0500
To: Bill Nottingham <notting@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] All my Pcmcia cards are 'eth0'
From: Andi Kleen <ak@muc.de>
Date: Fri, 21 Nov 2003 06:14:40 +0100
In-Reply-To: <Uajn.3lb.7@gated-at.bofh.it> (Bill Nottingham's message of
 "Fri, 21 Nov 2003 04:40:09 +0100")
Message-ID: <m34qwy5mm7.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <Ua09.2Wt.17@gated-at.bofh.it> <Uajn.3lb.7@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Nottingham <notting@redhat.com> writes:
>
> There are some situations where you have to jump through hoops
> because it can't atomically swap two device names (i.e.,
> eth0 <-> eth1, but the code itself seems to work ok in use here...

Adding such swapping should not be very hard if someone is motivated.
Interestingly you're the first to complain about it missing...

-Andi (who wrote nameif originally) 
