Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285367AbRLSQSL>; Wed, 19 Dec 2001 11:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285366AbRLSQSB>; Wed, 19 Dec 2001 11:18:01 -0500
Received: from pat.uio.no ([129.240.130.16]:49576 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S285364AbRLSQRw>;
	Wed, 19 Dec 2001 11:17:52 -0500
Date: Wed, 19 Dec 2001 17:16:50 +0100 (MET)
From: wikne@lynx.uio.no (Jon Wikne)
Message-Id: <200112191616.RAA07423@lynx.uio.no>
To: linux-kernel@vger.kernel.org
Subject: 2.4.16 rivafb memory recognition problem
Cc: ajoshi@shell.unixbox.com
X-Sun-Charset: US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I discovered a strange behaviour related to kernel memory recognition
when using the rivafb frame buffer option compiled into kernel 2.4.16.
The system in question has a Asus AGP7700 nVidia GeForce 2 GTS (32MB)
video card. It is a dual PIII SMP system, if that might matter.

When I select nVidia Riva support, at first it seemed to work perfectly.
But then I discovered that the kernel only recognizes 32MB of total
memory during boot! Excessive swapping is the result.

When instead I compile the kernel with VESA frame buffer support,
all other kernel config parameters the same, the resulting kernel
recognizes all of the 1GB physical memory actually installed in
this box.

Any ideas?


Cheers,
-- Jon Wikne
