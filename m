Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263501AbTDNPz2 (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 11:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263506AbTDNPz2 (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 11:55:28 -0400
Received: from fep01-mail.bloor.is.net.cable.rogers.com ([66.185.86.71]:43422
	"EHLO fep01-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S263501AbTDNPzV 
	(for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 11:55:21 -0400
Subject: FBCON - vesa graphics modes no longer work on Toshiba Laptop
From: Sean Estabrooks <seanlkml@rogers.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1050336424.32705.31.camel@linux1.classroom.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 14 Apr 2003 12:07:04 -0400
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep01-mail.bloor.is.net.cable.rogers.com from [24.102.213.170] using ID <seanlkml@rogers.com> at Mon, 14 Apr 2003 12:07:04 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Toshiba Satellite 4300 laptop with the following display adapter:

S3 Inc. 86C270-294 Savage/IX-MV (rev 11) 

2.4.20 kernel works well with vga=0x305 and uses the entire LCD panel.

2.5.67 kernel with vga=0x305 sets a graphic mode that only uses the
inner 640x480 set of pixels and the display is just a jumbled mess.  

I did try the latest fb patch and the problem remains.  Also found a
note that said to try "video=vesa:ywrap,pmipal,mtrr" and this didn't
work either.

Regards,
Sean


#
# Graphics support
#
CONFIG_FB=y
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_VIRTUAL is not set
 
#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_FONT_6x11=y
CONFIG_FONT_PEARL_8x8=y
CONFIG_FONT_ACORN_8x8=y
CONFIG_FONT_MINI_4x6=y
CONFIG_FONT_SUN8x16=y
CONFIG_FONT_SUN12x22=y
 
#
# Logo configuration
#
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
 


