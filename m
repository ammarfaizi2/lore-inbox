Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263385AbTH0OVN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 10:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbTH0OVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 10:21:13 -0400
Received: from 213.237.25.228.adsl.van.worldonline.dk ([213.237.25.228]:59952
	"EHLO www.zensonic.dk") by vger.kernel.org with ESMTP
	id S263385AbTH0OVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 10:21:11 -0400
Date: Wed, 27 Aug 2003 16:20:35 +0200
From: "Thomas S. Iversen" <zensonic@zensonic.dk>
To: linux-kernel@vger.kernel.org
Subject: Help with debugging of a framebuffer driver on a legacyfree system.
Message-ID: <20030827142035.GA25937@zensonic.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there 

As part of a project I am trying to write a framebuffer device
driver for a graphic chip. Up until now I have compiled my
code as a module and been doing insmod, rmmod and that have worked
nicely.

I then tried to compile the driver into the kernel but that
makes the kernel hang. As my development system are a legacy
free laptop and my driver initializes the screen, the kernel
hangs without me being able to figure out where and why that
happend.

So I seek advice on how to debug the driver! As said, the
laptop are legacy free, so I have not got a serial port. 
I have tried a usb->serial adapter, but that requires a driver.
Can I do USB->USB on another computer? Or?

Or am I stuck with coding my own printk variant and writing to the
screen or is there any other option I have not thought of?

Regards Thomas, Denmark
