Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130211AbQKTTyn>; Mon, 20 Nov 2000 14:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129851AbQKTTyZ>; Mon, 20 Nov 2000 14:54:25 -0500
Received: from hermes.cicese.mx ([158.97.1.34]:64687 "EHLO hermes.cicese.mx")
	by vger.kernel.org with ESMTP id <S130338AbQKTTyT>;
	Mon, 20 Nov 2000 14:54:19 -0500
Date: Mon, 20 Nov 2000 11:24:02 -0800
Message-Id: <200011201924.LAA15401@quantum.cicese.mx>
To: linux-kernel@vger.kernel.org
From: Serguei Miridonov <mirsev@cicese.mx>
Subject: Linux driver for DC10plus/LML33/Buz video capture cards V 0.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

November 20, 2000.

Thanks to Wolfgang Scherr, who was the first maintainer of this driver,
we now have support for Iomega Buz cards again. There are no changes for
current DC10plus and LML33 cards users (besides that dc10.[ch] files
have been renamed to zoran.[ch]), however I would like to ask them
together with owners of Iomega Buz cards to download and try this
driver. Please, read file README from this distribution before driver
compilation and installation.

The driver is Video4Linux compliant and contains extensions to provide
a full motion MJPEG compression and decompression in hardware using
Zoran chipset features. Since this driver initially was a derivative
from the driver for Buz Iomega cards written by Dr. Rainer Johanni,
http://www.johanni.de/munich-vision/buz/, they both have compatible
API. I hope that this API will become a part of V4L standard. 

Since version 0.5 the driver compiles and works with 2.2.x and 2.4.x
kernels. (I used 2.2.14, 2.2.16 and 2.4.0-test6 kernels for testing).
Please, be aware that some Linux distributors supply modified kernels
with their distributions and with such kernels the driver compilation
may fail. Unfortunately, I don't have time and other resources to keep
the driver compatible with every Linux distribution, therefore, only
official Linux kernels from www.kernel.org and its mirrors will be
supported. 

To download the driver and for other news and updates, please, visit

http://www.cicese.mx/~mirsev/Linux/DC10plus/

Supported Formats
=================

Card:              DC10/DC10plus             LML33/Buz

TV standard:       NTSC/PAL/SECAM            NTSC/PAL

Format:            Square pixel              CCIR.601
                   640x480 NTSC              720x480 NTSC
                   768x576 PAL/SECAM         720x576 PAL

Frame rates: 30 frames/60 fields per second NTSC
             25 frames/50 fields per second PAL/SECAM

The driver can be used by two programs at the same time. Using XawTV
you can watch what you are recording or playing back with lavtools.
(please, see warning note in README file supplied with the driver
distribution regarding this feature).

Good luck.

-- 
Serguei Miridonov
mirsev@cicese.mx


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
