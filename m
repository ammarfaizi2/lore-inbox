Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWIDMMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWIDMMc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 08:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbWIDMMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 08:12:32 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:20354 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750873AbWIDMMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 08:12:31 -0400
Message-ID: <44FC182C.7090008@garzik.org>
Date: Mon, 04 Sep 2006 08:12:28 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Grant Coady <gcoady.lk@gmail.com>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: PATA drivers queued for 2.6.19
References: <44FC0779.9030405@garzik.org> <po4of2pnhpc0325kqj2hd37b7eh3epcdsm@4ax.com>
In-Reply-To: <po4of2pnhpc0325kqj2hd37b7eh3epcdsm@4ax.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Coady wrote:
> I can't see an easy way to arrange multi-boot with different /etc/fstab 
> depending if I'm trying /dev/hdaX or /dev/sdaX.  Parallel '/' partitions?

That's actually pretty darn easy, with a modern distro.  Use filesystem 
labels, and LABEL= in your /etc/fstab.

The LABEL= feature allowed me to bounce between drivers/ide and libata a 
dozen times a day, when I was doing the initial libata development.

	Jeff



-- 
VGER BF report: H 3.84798e-12
