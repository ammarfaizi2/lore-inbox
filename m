Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136047AbRD0Obg>; Fri, 27 Apr 2001 10:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136049AbRD0Ob0>; Fri, 27 Apr 2001 10:31:26 -0400
Received: from dire.bris.ac.uk ([137.222.10.60]:62669 "EHLO dire.bris.ac.uk")
	by vger.kernel.org with ESMTP id <S136047AbRD0ObR>;
	Fri, 27 Apr 2001 10:31:17 -0400
Date: Fri, 27 Apr 2001 15:28:04 +0100 (BST)
From: Matt <madmatt@bits.bris.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Can the kernel access /?
Message-ID: <Pine.LNX.4.21.0104271521540.21006-100000@bits.bris.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm writing a device driver for a DSP card that requires some software
loaded onto the card for it to function, currently I'm copying the
software to the /dev node and the driver is doing the magic in it's
write() handler.

Can the driver pull the file from the filesystem if I were to pass the
path of the file as an argument on loading the module?

I'm not sure it can, but perhaps someone could settle my curiosity and
perhaps point me to some code that does this in the kernel?

I'm thinking that if it could, things like the P6 Microcode driver would
be perhaps done this way too...

Cheers

Matt

