Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271055AbRILWaP>; Wed, 12 Sep 2001 18:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271795AbRILW3y>; Wed, 12 Sep 2001 18:29:54 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39183 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271055AbRILW3x>; Wed, 12 Sep 2001 18:29:53 -0400
Subject: Re: User Space Emulation of Devices
To: hpa@zytor.com (H. Peter Anvin)
Date: Wed, 12 Sep 2001 23:34:22 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9nomp1$jt7$1@cesium.transmeta.com> from "H. Peter Anvin" at Sep 12, 2001 03:14:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15hIaN-0005Ta-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > How do you pass an ioctl ? If any parameter is a pointer you actually need a 
> > complex protocol for passing memory content to make it useful.
> > 
> You need a parameter marshalling system; however, they do exist.  It
> might actually be that the best way to deal with this is to make a
> general module framework and compile a specific module to marshall the
> parameters of the device you want to emulate.

Didnt someone announce a kernel mode corba daemon a while back ?
