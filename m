Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbUBHJIo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 04:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262965AbUBHJIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 04:08:44 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:48878 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S262913AbUBHJIm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 04:08:42 -0500
Date: Sun, 8 Feb 2004 01:08:30 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Francis, Chong Chan Fai" <francis.ccf@polyu.edu.hk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB 2.0 mass storage problem
Message-ID: <20040208090830.GC18674@srv-lnx2600.matchmail.com>
Mail-Followup-To: "Francis, Chong Chan Fai" <francis.ccf@polyu.edu.hk>,
	linux-kernel@vger.kernel.org
References: <20040208063447.GB18674@srv-lnx2600.matchmail.com> <200402080657.i186v7p10163@mailgate01.ctimail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402080657.i186v7p10163@mailgate01.ctimail.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 08, 2004 at 02:58:17PM +0800, Francis, Chong Chan Fai wrote:
> > Probably a problem with pcmcia.
> 
> > I've used a usb 2.0 pci card, but the cpu usage is so high that it's just
> as
> > fast as the same card using the uhci-hcd driver -- and uhci uses *much*
> > less cpu.
> 
> Thank you for your reply.
> 
> I don't have the performance problem with USB2.0, it read a file lightning
> fast (compare with USB 1.0), but just hang shortly after a few files.

It was a pII 300... not a dino, but getting old.

> 
> I using USB 1.0 as a work around, but my disk is 120G and the speed is
> terrible.
> 
> Because the command " lspci " show the PCMCIA bus correctly, I didn't
> thought it could be a problem. If it is the case, what can I do? 

Can you run "dd < /dev/sda > /dev/null" on the usb drive without a hang/crash?

Turn on the nmi_watchdog.  There is documentation in the kernel source
tree, and on the web...
