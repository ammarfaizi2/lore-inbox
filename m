Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751789AbWHTXHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbWHTXHg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 19:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbWHTXHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 19:07:36 -0400
Received: from 1wt.eu ([62.212.114.60]:65296 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751789AbWHTXHf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 19:07:35 -0400
Date: Mon, 21 Aug 2006 01:07:22 +0200
From: Willy Tarreau <w@1wt.eu>
To: Grant Coady <gcoady.lk@gmail.com>
Cc: linux-kernel@vger.kernel.org, Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: 2.4.34-pre1 USB mass-storage burped...
Message-ID: <20060820230722.GG602@1wt.eu>
References: <9aide2d3ano7v3853kgfhhpbgarmns4t2f@4ax.com> <20060819084724.GA2078@1wt.eu> <78mde2t57okmmnaeslpcen9884mu0v3epb@4ax.com> <20060819100728.GA25405@1wt.eu> <6kohe2tuvg9mr1adfpj05k9jvkca1arhe9@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6kohe2tuvg9mr1adfpj05k9jvkca1arhe9@4ax.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 08:58:29AM +1000, Grant Coady wrote:
> On Sat, 19 Aug 2006 12:07:28 +0200, Willy Tarreau <w@1wt.eu> wrote:
> 
> >On Sat, Aug 19, 2006 at 07:39:06PM +1000, Grant Coady wrote:
> >> On Sat, 19 Aug 2006 10:47:24 +0200, Willy Tarreau <w@1wt.eu> wrote:
> >> 
> >> >Hi Grant,
> >> >
> >> >On Sat, Aug 19, 2006 at 06:41:50PM +1000, Grant Coady wrote:
> >> ...
> >> >Have you tried building over USB HDD for another kernel (at least 2.4.33) ?
> >> 
> >> No.
> 
> Testing kernel rebuilds on a USB-HDD connected mass-storage, follow up 
> to 2.4.34-pre1 'burped' report:
> 
> 2.4.33: >100 rebuilds without error
> 
> 2.4.34-pre1: 163 rebuilds without error, maybe I kicked the USB-HDD 
> (it's on the floor ;) other day?  
> 
> Report other day seems to be a once off glitch, been running overnight at 
> about 6 mins per rebuild from 'make mrproper' over USB2.0 link from Via 
> chipset to Genesys GL811 USB <-> ATA/ATAPI bridge.
> 
> grant@sempro:~$ /sbin/lspci |grep USB
> 00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
> 00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
> 00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
> 00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
> 00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
> 
> HDD is ten year old 815MB Toshiba MK1926FCV that throws a little fit if 
> picked up while in operation.  It just did when I turned it over to 
> see the part number.  No kernel build error this time though ;)
> 
> Grant.

Perfect,
Thanks Grant for your tests. I feel more comfortable now that we don't have
to suspect a problem introduced by Pete's fix.

Cheers,
Willy

