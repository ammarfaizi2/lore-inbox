Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312887AbSDFX4s>; Sat, 6 Apr 2002 18:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312889AbSDFX4r>; Sat, 6 Apr 2002 18:56:47 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:16009 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S312887AbSDFX4q>; Sat, 6 Apr 2002 18:56:46 -0500
Date: Sat, 6 Apr 2002 16:56:45 -0700
Message-Id: <200204062356.g36Nujh03555@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org
Subject: bttv compile failure in 2.5.8-pre2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Compiling 2.5.8-pre2, I got the following:

bttv-driver.c:2650: `video_generic_ioctl' undeclared here (not in a function)
bttv-driver.c:2650: initializer element is not constant
bttv-driver.c:2650: (near initialization for `bttv_fops.ioctl')
bttv-driver.c:2655: initializer element is not constant
bttv-driver.c:2655: (near initialization for `bttv_fops')
bttv-driver.c:2664: unknown field `kernel_ioctl' specified in initializer
bttv-driver.c:2771: `video_generic_ioctl' undeclared here (not in a function)
bttv-driver.c:2771: initializer element is not constant
bttv-driver.c:2771: (near initialization for `radio_fops.ioctl')
bttv-driver.c:2773: initializer element is not constant
bttv-driver.c:2773: (near initialization for `radio_fops')
bttv-driver.c:2781: unknown field `kernel_ioctl' specified in initializer
make[3]: *** [bttv-driver.o] Error 1

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
