Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265165AbTFMQrK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 12:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265229AbTFMQrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 12:47:09 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:21252 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265165AbTFMQrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 12:47:02 -0400
Date: Fri, 13 Jun 2003 18:00:47 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Real multi-user linux
In-Reply-To: <E19QcfW-0003ce-00@calista.inka.de>
Message-ID: <Pine.LNX.4.44.0306131757341.29353-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > is it possible to use several logical terminals
> > (=tupels of monitor, keyboard and mouse) directly
> > connected to _one_ system?
> 
> Yes sure.

Yes but it requires massive surgery to the kernel.

> > But is there a possibility to group these to allow two
> > users work simultanously on the same machine without
> > having to go via serial console or network?
> 
> the main problem is the hardware. It is most often easier to have a diskless
> terminal connected via network, than to have a VGA cable to two workplaces.
> 
> Linux supports multiple XServers (on multiple cards or cards with multiple
> ports), can you can configure them for multiple serial ports or usb ports
> for the mouse. For the keyboard you can have one ps2 and multiple usb ports
> (under x). I am not sure how the console handles multiple usb keyboards.

Its flaky. The XServers need some patches to make it behave correctly. We 
have working X servers that do this. Alot of configuring has to be done 
to. This also has been solved. We also had it working with multiple sound 
cards.
  BTW this is what the company I'm creating right now does. I just wanted 
to have a actually working product before I formed a company.





