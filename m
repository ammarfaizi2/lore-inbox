Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266372AbUAHXNf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 18:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266376AbUAHXNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 18:13:35 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:33741 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S266372AbUAHXN1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 18:13:27 -0500
Date: Fri, 9 Jan 2004 00:12:17 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New FBDev patch
Message-ID: <20040108231217.GB7085@louise.pinerecords.com>
References: <Pine.LNX.4.44.0401082108080.12797-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <Pine.LNX.4.44.0401082108080.12797-100000@phoenix.infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan-08 2004, Thu, 22:03 +0000
James Simmons <jsimmons@infradead.org> wrote:

> This is the latest patch against 2.6.0-rc3. Give it a try.
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
drivers/built-in.o(.init.data+0x33c): undefined reference to adeonfb_setup'
make: *** [.tmp_vmlinux1] Error 1

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
CONFIG_FB_RADEON=y
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_VIRTUAL is not set

-- 
Tomas Szepe <szepe@pinerecords.com>
