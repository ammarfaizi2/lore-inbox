Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266691AbUBQWaz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 17:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266693AbUBQW1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 17:27:39 -0500
Received: from gate.crashing.org ([63.228.1.57]:47523 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266691AbUBQWYa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 17:24:30 -0500
Subject: Re: Radeonfb problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Damian Kolkowski <damian@kolkowski.no-ip.org>
Cc: Kronos <kronos@kronoz.cjb.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Sergio Vergata <vergata@stud.fbi.fh-darmstadt.de>
In-Reply-To: <20040217215738.ALLYOURBASEAREBELONGTOUS.B9706@kolkowski.no-ip.org>
References: <200402172008.39887.vergata@stud.fbi.fh-darmstadt.de>
	 <20040217203604.GA19110@dreamland.darkstar.lan>
	 <20040217211120.ALLYOURBASEAREBELONGTOUS.A8392@kolkowski.no-ip.org>
	 <20040217213441.GA22103@dreamland.darkstar.lan>
	 <20040217215738.ALLYOURBASEAREBELONGTOUS.B9706@kolkowski.no-ip.org>
Content-Type: text/plain
Message-Id: <1077056532.1076.27.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 18 Feb 2004 09:22:12 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-18 at 08:57, Damian Kolkowski wrote:
> * Kronos <kronos@kronoz.cjb.net> [2004-02-17 22:51]:
> > > 2.6.3-rc4 with new radeonfb looks better, but in lilo.con append for radeonfb
> > > wont work.
> > 
> > What do you mean? What are passing to the kernel?
> 
> For example:
> 
> append = "video=radeon:1024x768-32@100" works for 2.4.x
> append = "video=radeonfb:1024x768-32@100 works for 2.6.x
> 
> but for new radeonfb _radeonfb_ in append won't work, my screean start with
> small res on 36 Hz ;-) So I need to use fbset.
> 
> Besides don't use 2.6.x even on desktop, that was only a test with new
> radeonfb from Ben H.

Ugh ? Send me a dmesg log at boot please without any command
line. radeonfb should set your display to the native panel size
by default

Ben.


