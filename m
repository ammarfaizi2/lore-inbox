Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932603AbWAJUoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932603AbWAJUoz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 15:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932607AbWAJUoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 15:44:54 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:48768 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932603AbWAJUoy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 15:44:54 -0500
Date: Tue, 10 Jan 2006 21:44:43 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
cc: Andi Kleen <ak@suse.de>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Console debugging wishlist was: Re: oops pauser.
In-Reply-To: <20060110202920.GA5479@filer.fsl.cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0601102143530.16049@yvahk01.tjqt.qr>
References: <20060105045212.GA15789@redhat.com> <p73vewtw8bh.fsf@verdi.suse.de>
 <Pine.LNX.4.61.0601102121400.16049@yvahk01.tjqt.qr>
 <20060110202920.GA5479@filer.fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> I doubt this scrollback buffer is implemented as part of the video cards. 
>> It is rather a kernel invention, and therefore uses standard RAM. But the 
>> idea is good, preferably make it a CONFIG_ option.
>
>There is a config option that lets you specify the size of this buffer:
>CONFIG_LOG_BUF_SHIFT

menuconfig help says

    "Select kernel log buffer size as a power of 2."

That does not sound like "console scroll buffer".



Jan Engelhardt
-- 
