Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311647AbSDJJun>; Wed, 10 Apr 2002 05:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312031AbSDJJum>; Wed, 10 Apr 2002 05:50:42 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:58003 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S311647AbSDJJum>; Wed, 10 Apr 2002 05:50:42 -0400
Message-ID: <3CB40AF0.693C5130@delusion.de>
Date: Wed, 10 Apr 2002 11:50:40 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.7 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: bttv-driver broken in 2.5.8-pre
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The bttv driver in 2.5.8-pre doesn't compile:

bttv-driver.c:2650: `video_generic_ioctl' undeclared here (not in a function)
bttv-driver.c:2650: initializer element is not constant
bttv-driver.c:2650: (near initialization for `bttv_fops.ioctl')
bttv-driver.c:2664: unknown field `kernel_ioctl' specified in initializer
bttv-driver.c:2771: `video_generic_ioctl' undeclared here (not in a function)
bttv-driver.c:2771: initializer element is not constant
bttv-driver.c:2771: (near initialization for `radio_fops.ioctl')
bttv-driver.c:2781: unknown field `kernel_ioctl' specified in initializer

Gerd's latest patch v4l2-01-v4l2-api-2.5.8-pre2.diff doesn't fix it either.

-Udo.
