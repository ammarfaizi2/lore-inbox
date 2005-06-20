Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbVFTUcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVFTUcf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 16:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbVFTUca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 16:32:30 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:30679 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261573AbVFTUb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 16:31:29 -0400
Date: Mon, 20 Jun 2005 22:25:02 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: linux-thinkpad@linux-thinkpad.org, linux-kernel@vger.kernel.org
Subject: Re: [ltp] Re: IBM HDAPS Someone interested?
Message-ID: <20050620202502.GF477@openzaurus.ucw.cz>
References: <42B6F6F6.2040704@zipman.it> <005b01c575bd_724fac60_600cc60a@amer.sykes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005b01c575bd_724fac60_600cc60a@amer.sykes.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > No, the software, under Windows, is an application; you can control
> > the behaviour of the disk based on the response of the chip.
> >
> > Anyway I don't think it's a simple task to create a driver for the
> > accelerometer; one thing is to read the data from the chip (I suppose
> > it's not too hard), but the most part of the job is to know what to do
> > with the data you read.
> >
> > IBM developed a mathematical model that describes the typical usage of
> > the ThinkPad, and they based the action on this math model. Developing
> > a free math model is quite hard and also we cannot destroy 5 or 6 TP
> > only to see how the signals are produced by the chip in all the
> > possible situations (IBM instead can destroy as much TP as
> > they want :(

You basically want to detect free fall. You don't need to make the machine
hit the concrete at the bottom; as long as it detects free fall, it is okay.
It does not seem *that* hard to me (but I do speech recognition at university :-).

Anyway, accelerometers are usefull for other stuff, too, like playing neverball.

Oh, and there should be reasonable way to develop this. First, detect
"machine sitting on unmoving table", and park heads if you detect anythink
else. Now, someone who really cares can develop model for "train", but most users are already quite well protected after you do "table" model.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

