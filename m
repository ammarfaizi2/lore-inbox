Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290818AbSAaBiD>; Wed, 30 Jan 2002 20:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290814AbSAaBfY>; Wed, 30 Jan 2002 20:35:24 -0500
Received: from ns.suse.de ([213.95.15.193]:9993 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290817AbSAaBe7>;
	Wed, 30 Jan 2002 20:34:59 -0500
Date: Thu, 31 Jan 2002 02:34:57 +0100
From: Dave Jones <davej@suse.de>
To: mmcclell@bigfoot.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: ov511 verbose startup.
Message-ID: <20020131023457.D31313@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>, mmcclell@bigfoot.com,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The changes to ov511 in 2.5.3 seem to generate excessive
amounts of blurb on boot up for me..

ov511.c: USB OV511+ camera found
ov511.c: model: Creative Labs WebCam 3
ov511.c: Sensor is an OV7620
ov511.c: Device registered on minor 0
usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 137 ret -75
usb_control/bulk_msg: timeout
usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -110
usb_control/bulk_msg: timeout
usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -110
...
repeat last two lines another dozen or so times...

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
