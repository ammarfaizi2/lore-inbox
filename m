Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267405AbRG2AhQ>; Sat, 28 Jul 2001 20:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267418AbRG2Ag5>; Sat, 28 Jul 2001 20:36:57 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:52486 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267405AbRG2Agv>; Sat, 28 Jul 2001 20:36:51 -0400
Subject: Re: make rpm
To: vonbrand@sleipnir.valparaiso.cl (Horst von Brand)
Date: Sun, 29 Jul 2001 01:38:09 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Horst von Brand" at Jul 28, 2001 08:33:42 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Qeav-0008P4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> Alan Cox <alan@lxorguk.ukuu.org.uk> said:
> > I've been meaning to do this one for a while and I now have it working so
> > that with my current -ac kernel working tree I can type
> > 
> > 	make rpm
> > 
> > and out puts kernel-2.4.7ac3-1.i386.rpm
> 
> Great idea!
> 
> Just the bunch of "echo this or that" is ugly as sin... why not a
> kernel.spec template that gets its version &c substituted by sed(1) or
> something?

Well for one because its easier to hack on at the moment. I still need to
finish up packing the right pieces, and also checking if the user
has an /sbin/installkernel and also if they are not using GRUB need to then
rerun lilo

Alan

