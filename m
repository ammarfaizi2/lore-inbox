Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266390AbSLJAEL>; Mon, 9 Dec 2002 19:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266487AbSLJAEL>; Mon, 9 Dec 2002 19:04:11 -0500
Received: from conure.mail.pas.earthlink.net ([207.217.120.54]:62341 "EHLO
	conure.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S266390AbSLJAED>; Mon, 9 Dec 2002 19:04:03 -0500
Date: Mon, 9 Dec 2002 17:04:27 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Christoph Hellwig <hch@infradead.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [BK fbdev] Yet again more fbdev updates.
In-Reply-To: <20021209233749.A8008@infradead.org>
Message-ID: <Pine.LNX.4.33.0212091651540.2360-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Linus,
>
> any chance you could pull James' updates?  He has been sending fbdev updates
> that fix known issues with many drivers for a long time but I can't even
> remember when you merged it the last time.  Most fbdev drivers are pretty
> unusable in mainline without his fixes.
>
> James,
>
> could you please provide diffstat output, bk changes -L output and a
> unified diff for review of the actual changes?

Diff against latest BK 2.5.50 tree is at

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

bk changes output is:

ChangeSet@1.860, 2002-12-09 16:03:32-08:00, jsimmons@maxwell.earthlink.net
  Merge maxwell.earthlink.net:/usr/src/linus-2.5
  into maxwell.earthlink.net:/usr/src/fbdev-2.5

ChangeSet@1.857.1.3, 2002-12-09 15:47:42-08:00, jsimmons@maxwell.earthlink.net
  New NVIDIA and Radeon cards pci ids. Soon I will add support for these :-) Also a needed fix for fbcon.c.

ChangeSet@1.857.1.2, 2002-12-09 08:37:31-08:00, jsimmons@maxwell.earthlink.net
  Merge maxwell.earthlink.net:/usr/src/linus-2.5
  into maxwell.earthlink.net:/usr/src/fbdev-2.5

ChangeSet@1.839.2.2, 2002-12-07 19:24:53-08:00, jsimmons@maxwell.earthlink.net
  Merge maxwell.earthlink.net:/usr/src/linus-2.5
  into maxwell.earthlink.net:/usr/src/fbdev-2.5

ChangeSet@1.831.21.2, 2002-12-07 10:23:33-08:00, jsimmons@maxwell.earthlink.net
  Merge maxwell.earthlink.net:/usr/src/linus-2.5
  into maxwell.earthlink.net:/usr/src/fbdev-2.5

ChangeSet@1.831.10.62, 2002-12-06 16:17:04-08:00, jsimmons@kozmo.(none)
  Fits the other accel protocols. Fix for blanking.

ChangeSet@1.831.17.2, 2002-12-06 12:36:53-08:00, jsimmons@kozmo.(none)
  VGA text mode handling cleanup. Rusty's janitoral cleanups.

ChangeSet@1.831.16.2, 2002-12-06 10:18:16-08:00, jsimmons@kozmo.(none)
  Merge kozmo.(none):/usr/src/linus-2.5
  into kozmo.(none):/usr/src/fbdev-2.5

ChangeSet@1.831.15.2, 2002-12-06 07:32:36-08:00, jsimmons@maxwell.earthlink.net
  Merge maxwell.earthlink.net:/usr/src/linus-2.5
  into maxwell.earthlink.net:/usr/src/fbdev-2.5

ChangeSet@1.825.11.4, 2002-12-04 20:37:21-08:00, jsimmons@maxwell.earthlink.net
  POrted iga fbdev driver to new api. Untested.

ChangeSet@1.825.11.3, 2002-12-04 18:09:35-08:00, jsimmons@maxwell.earthlink.net
  Synced to Linus BK tree.

ChangeSet@1.825.11.2, 2002-12-04 17:43:55-08:00, jsimmons@maxwell.earthlink.net
  Merge

ChangeSet@1.797.178.2, 2002-12-04 17:10:40-08:00, jsimmons@maxwell.earthlink.net
  Supprt for switching hardware from/to vga text mode.

ChangeSet@1.797.153.41, 2002-12-02 11:48:57-08:00, jsimmons@kozmo.(none)
  Ported riva and vga16fb over to new api. Thanks Antonia Daplas!!! More optimizations in fbcon.c

ChangeSet@1.797.153.40, 2002-12-02 09:49:02-08:00, jsimmons@kozmo.(none)
  Merge kozmo.(none):/usr/src/linus-2.5
  into kozmo.(none):/usr/src/fbdev-2.5

ChangeSet@1.797.156.3, 2002-12-02 07:38:54-08:00, jsimmons@kozmo.(none)
  Made fbcon modular.

ChangeSet@1.797.156.2, 2002-11-29 09:38:38-08:00, jsimmons@kozmo.(none)
  Made it modular.

ChangeSet@1.797.156.1, 2002-11-27 16:08:48-08:00, jsimmons@kozmo.(none)
  Merge

ChangeSet@1.797.120.7, 2002-11-27 14:40:32-08:00, jsimmons@kozmo.(none)
  Accel wrapper is now intergarted into fbcon.c. VESA fb fixes

ChangeSet@1.797.120.6, 2002-11-27 07:50:13-08:00, jsimmons@maxwell.earthlink.net
  Diver updates.

ChangeSet@1.797.120.5, 2002-11-26 16:04:19-08:00, jsimmons@kozmo.(none)
  C99 fixes. Framebuffer console fix.

ChangeSet@1.797.120.4, 2002-11-26 09:59:16-08:00, jsimmons@kozmo.(none)
  Moved over fbcon to use the accel api only. This will shrink the code considerably.

ChangeSet@1.797.120.3, 2002-11-23 12:45:55-08:00, jsimmons@maxwell.earthlink.net
  Use the new name of the software cursor function.

ChangeSet@1.797.120.2, 2002-11-23 12:36:29-08:00, jsimmons@maxwell.earthlink.net
  Use remote for now to make sync of trees work.

ChangeSet@1.797.126.3, 2002-11-23 11:50:08-08:00, jsimmons@maxwell.earthlink.net
  Ported Mach64 and NVIDIA driver to final api. A bunch of improvements and bug fixes.

ChangeSet@1.797.126.2, 2002-11-23 09:50:57-08:00, jsimmons@maxwell.earthlink.net
  Merge maxwell.earthlink.net:/usr/src/linus-2.5
  into maxwell.earthlink.net:/usr/src/fbdev-2.5

ChangeSet@1.797.120.1, 2002-11-22 14:40:17-08:00, jsimmons@kozmo.(none)
  Merge kozmo.(none):/usr/src/linus-2.5
  into kozmo.(none):/usr/src/fbdev-2.5

ChangeSet@1.797.115.2, 2002-11-22 13:47:35-08:00, jsimmons@kozmo.(none)
  The software cursor works for any pixel arrangement

ChangeSet@1.797.115.1, 2002-11-22 10:02:30-08:00, jsimmons@kozmo.(none)
  Merge kozmo.(none):/usr/src/linus-2.5
  into kozmo.(none):/usr/src/fbdev-2.5

ChangeSet@1.797.100.1, 2002-11-21 07:58:29-08:00, jsimmons@maxwell.earthlink.net
  Merge bk://fbdev.bkbits.net/fbdev-2.5
  into maxwell.earthlink.net:/usr/src/fbdev-2.5

ChangeSet@1.797.78.16, 2002-11-20 15:50:09-08:00, jsimmons@kozmo.(none)
  Merge kozmo.(none):/usr/src/linus-2.5
  into kozmo.(none):/usr/src/fbdev-2.5

ChangeSet@1.797.82.3, 2002-11-19 12:53:44-08:00, jsimmons@kozmo.(none)
  Nuked font related info in struct display. Almost gone now.

ChangeSet@1.797.82.2, 2002-11-19 11:36:22-08:00, jsimmons@kozmo.(none)
  Creation of default mode. We create and set the hardware once then clone the data each VC. This is much sanier.

ChangeSet@1.797.82.1, 2002-11-19 09:49:40-08:00, jsimmons@kozmo.(none)
  Merge kozmo.(none):/usr/src/linus-2.5
  into kozmo.(none):/usr/src/fbdev-2.5

ChangeSet@1.797.76.2, 2002-11-19 07:30:34-08:00, jsimmons@maxwell.earthlink.net
  Merge bk://fbdev.bkbits.net/fbdev-2.5
  into maxwell.earthlink.net:/usr/src/fbdev-2.5

ChangeSet@1.797.67.1, 2002-11-18 10:27:55-08:00, jsimmons@kozmo.(none)
  Merge kozmo.(none):/usr/src/linus-2.5
  into kozmo.(none):/usr/src/fbdev-2.5

ChangeSet@1.797.40.3, 2002-11-18 09:31:34-08:00, jsimmons@kozmo.(none)
  Start of intergartion of fbcon-accel into the core fbcon code.

ChangeSet@1.797.43.3, 2002-11-16 17:36:03-08:00, jsimmons@maxwell.earthlink.net
  Merge

ChangeSet@1.797.43.2, 2002-11-16 17:21:19-08:00, jsimmons@maxwell.earthlink.net
  Merge maxwell.earthlink.net:/usr/src/linus-2.5
  into maxwell.earthlink.net:/usr/src/fbdev-2.5

ChangeSet@1.797.40.2, 2002-11-15 17:37:46-08:00, jsimmons@kozmo.(none)
  Massive cleanup of struct display. It will be going away.

ChangeSet@1.797.22.9, 2002-11-15 14:01:40-08:00, jsimmons@kozmo.(none)
  Moving over to console_font_op to get ride of struct display.

ChangeSet@1.797.22.8, 2002-11-15 09:48:21-08:00, jsimmons@kozmo.(none)
  Cleaned up the cursor api. Now it uses fb_imaeg which makes sense since a cursor is a image.More code cleanup for fbcon.c. Removal of excess elements passed into functions.

ChangeSet@1.797.22.7, 2002-11-15 09:36:23-08:00, jsimmons@kozmo.(none)
  Merge kozmo.(none):/usr/src/linus-2.5
  into kozmo.(none):/usr/src/fbdev-2.5

ChangeSet@1.797.22.6, 2002-11-14 16:55:10-08:00, jsimmons@kozmo.(none)
  Start of hardware rotation. PDA devices have often rotated screens with respect to the keyboard.'

ChangeSet@1.797.22.4, 2002-11-14 14:08:32-08:00, jsimmons@kozmo.(none)
  Major fixes for the software accel functions. We have the penguin back.

ChangeSet@1.797.22.3, 2002-11-14 11:16:22-08:00, jsimmons@kozmo.(none)
  fbgen is gone and now we have cfbcursor.c

ChangeSet@1.797.22.2, 2002-11-13 16:13:32-08:00, jsimmons@kozmo.(none)
  Grabbed the PPC drivers and in the process of porting to the latest api. Can now use driver specific read and write functions

ChangeSet@1.797.6.3, 2002-11-12 08:04:25-08:00, jsimmons@maxwell.earthlink.net
  Simplification of the code.

ChangeSet@1.797.11.1, 2002-11-11 11:37:22-08:00, jsimmons@kozmo.(none)
  Merge bk://fbdev@bkbits.net/fbdev-2.5
  into kozmo.(none):/usr/src/fbdev-2.5

ChangeSet@1.797.4.3, 2002-11-10 13:03:09-08:00, jsimmons@maxwell.earthlink.net
  Fixed the anakin and noemagic framebuffer driver. Made font selection depeneded on framebuffer consoel instead of just framebuffer support. Fixed return to be int for tx3912 framebuffer.

ChangeSet@1.797.4.2, 2002-11-09 13:10:43-08:00, jsimmons@maxwell.earthlink.net
  Auto merged except for parisc Kconfig. I have to sync by hand.

ChangeSet@1.786.1.96, 2002-11-08 00:03:44-08:00, jsimmons@maxwell.earthlink.net
  Several fixes relating to modules. Ported over the vga16fb driver to the new api.

ChangeSet@1.786.1.95, 2002-11-07 13:47:46-08:00, jsimmons@maxwell.earthlink.net
  Moved stuff into drivers/video/console.

ChangeSet@1.786.1.94, 2002-11-07 13:33:20-08:00, jsimmons@maxwell.earthlink.net
  Merge

ChangeSet@1.786.1.93, 2002-11-07 09:07:28-08:00, jsimmons@maxwell.earthlink.net
  Bug fixes!!

ChangeSet@1.786.1.92, 2002-11-02 18:04:34-08:00, jsimmons@maxwell.earthlink.net
  Merge maxwell.earthlink.net:/usr/src/linus-2.5
  into maxwell.earthlink.net:/usr/src/fbdev-2.5

ChangeSet@1.786.162.3, 2002-11-01 17:07:16-08:00, jsimmons@maxwell.earthlink.net
  Neomagic and HGA updates. MAde the software accel code modular. So code cleanup in fbcon. More to go.

ChangeSet@1.786.162.2, 2002-11-01 15:37:07-08:00, jsimmons@maxwell.earthlink.net
  Merge maxwell.earthlink.net:/usr/src/linus-2.5
  into maxwell.earthlink.net:/usr/src/fbdev-2.5

ChangeSet@1.786.133.3, 2002-10-31 12:06:21-08:00, jsimmons@maxwell.earthlink.net
  Moved all console configuration out of arch directories into drivers/video/console. Allow resize of a single VC via the tty layer. Nuked GET_FB_IDX.

ChangeSet@1.786.133.2, 2002-10-30 20:57:19-08:00, jsimmons@maxwell.earthlink.net
  Ug. Synced up.

ChangeSet@1.786.125.2, 2002-10-30 09:57:16-08:00, jsimmons@maxwell.earthlink.net
  Merge maxwell.earthlink.net:/usr/src/linus-2.5
  into maxwell.earthlink.net:/usr/src/fbdev-2.5

ChangeSet@1.786.115.2, 2002-10-29 20:29:15-08:00, jsimmons@maxwell.earthlink.net
  Merge maxwell.earthlink.net:/usr/src/linus-2.5
  into maxwell.earthlink.net:/usr/src/fbdev-2.5

ChangeSet@1.786.107.4, 2002-10-29 14:42:41-08:00, jsimmons@maxwell.earthlink.net
  Moved AGP and DRM code back to drivers/char until a proper solution is done for handling AGP/DMA based framebuffer devices.

ChangeSet@1.786.107.3, 2002-10-29 12:06:00-08:00, jsimmons@maxwell.earthlink.net
  Updates to STI framebuffer and STI console. Cleanup of include/video and a few minor fixes.

ChangeSet@1.786.107.2, 2002-10-29 11:18:47-08:00, jsimmons@maxwell.earthlink.net
  Merge maxwell.earthlink.net:/usr/src/linus-2.5
  into maxwell.earthlink.net:/usr/src/fbdev-2.5

ChangeSet@1.786.52.5, 2002-10-28 16:08:25-08:00, jsimmons@maxwell.earthlink.net
  Merge maxwell.earthlink.net:/usr/src/linus-2.5
  into maxwell.earthlink.net:/usr/src/fbdev-2.5

ChangeSet@1.786.52.4, 2002-10-24 10:59:49-07:00, jsimmons@maxwell.earthlink.net
  Moved over fbcon related files to the video/console directory. I also updated a few more drivers to the new api.

ChangeSet@1.786.52.3, 2002-10-21 10:28:49-07:00, jsimmons@maxwell.earthlink.net
  Cleaned up the console blank handling.

ChangeSet@1.786.52.2, 2002-10-21 10:15:32-07:00, jsimmons@maxwell.earthlink.net
  Merge maxwell.earthlink.net:/usr/src/linus-2.5
  into maxwell.earthlink.net:/usr/src/fbdev-2.5

ChangeSet@1.786.25.4, 2002-10-18 13:48:05-07:00, jsimmons@maxwell.earthlink.net
  Added a cursor api.

ChangeSet@1.786.25.3, 2002-10-18 11:48:32-07:00, jsimmons@maxwell.earthlink.net
  Merge maxwell.earthlink.net:/usr/src/linus-2.5
  into maxwell.earthlink.net:/usr/src/fbdev-2.5

ChangeSet@1.786.9.3, 2002-10-16 21:27:33-07:00, jsimmons@maxwell.earthlink.net
  Synced up to Linus tree. Fixed the conflict.

ChangeSet@1.786.9.2, 2002-10-16 21:12:20-07:00, jsimmons@maxwell.earthlink.net
  Synced up.

ChangeSet@1.786.4.3, 2002-10-16 21:06:36-07:00, jsimmons@maxwell.earthlink.net
  The last of the console code inside the frmaebuffer layer. I also moved all the graphics related code into the drivers/video directory.

ChangeSet@1.786.4.2, 2002-10-16 11:18:08-07:00, jsimmons@maxwell.earthlink.net
  Merge maxwell.earthlink.net:/usr/src/linus-2.5
  into maxwell.earthlink.net:/usr/src/fbdev-2.5

ChangeSet@1.781.1.13, 2002-10-16 11:08:50-07:00, jsimmons@maxwell.earthlink.net
  Oops. Forgot to include sis_accel.o

ChangeSet@1.781.1.12, 2002-10-16 10:46:14-07:00, jsimmons@maxwell.earthlink.net
  Cleaned up and moved all the graphics related code inf drivers/video and move the console display related stuff into lower directory called console.

ChangeSet@1.781.1.11, 2002-10-14 09:38:39-07:00, jsimmons@maxwell.earthlink.net
  Replace with Russell's driver.

ChangeSet@1.781.1.10, 2002-10-14 09:34:28-07:00, jsimmons@maxwell.earthlink.net
  Uses Russell's latest driver.

ChangeSet@1.781.5.11, 2002-10-12 12:53:47-07:00, jsimmons@maxwell.earthlink.net
  Removed last console and old api related things. Removed experimental flags.

ChangeSet@1.781.5.10, 2002-10-12 11:16:44-07:00, jsimmons@maxwell.earthlink.net
  Merge maxwell.earthlink.net:/usr/src/linus-2.5
  into maxwell.earthlink.net:/usr/src/fbdev-2.5

ChangeSet@1.738.14.2, 2002-10-11 11:49:40-07:00, jsimmons@maxwell.earthlink.net
  Merge maxwell.earthlink.net:/usr/src/linus-2.5
  into maxwell.earthlink.net:/usr/src/fbdev-2.5

ChangeSet@1.714.13.2, 2002-10-09 13:54:17-07:00, jsimmons@maxwell.earthlink.net
  Merge maxwell.earthlink.net:/usr/src/linus-2.5
  into maxwell.earthlink.net:/usr/src/fbdev-2.5

ChangeSet@1.573.118.15, 2002-10-09 08:34:30-07:00, jsimmons@maxwell.earthlink.net
  Removed currcon and other console related code. Very little is now left.

ChangeSet@1.573.118.14, 2002-10-08 11:22:38-07:00, jsimmons@maxwell.earthlink.net
  Merge maxwell.earthlink.net:/usr/src/linus-2.5
  into maxwell.earthlink.net:/usr/src/fbdev-2.5

ChangeSet@1.497.104.5, 2002-09-12 15:27:08-07:00, jsimmons@maxwell.earthlink.net
  Cleanup to match closely Linus tree.

ChangeSet@1.497.104.4, 2002-09-12 15:16:51-07:00, jsimmons@maxwell.earthlink.net
  Auto merged

ChangeSet@1.497.47.2, 2002-09-12 12:06:08-07:00, jsimmons@maxwell.earthlink.net
  Remove old fbcon-cfb files.

ChangeSet@1.497.33.1, 2002-08-28 22:56:02-07:00, jsimmons@maxwell.earthlink.net
  Merge maxwell.earthlink.net:/usr/src/linus-2.5
  into maxwell.earthlink.net:/usr/src/fbdev-2.5

ChangeSet@1.497.27.1, 2002-08-27 22:05:49-07:00, jsimmons@maxwell.earthlink.net
  Merge http://fbdev.bkbits.net/fbdev-2.5
  into maxwell.earthlink.net:/usr/src/fbdev-2.5

ChangeSet@1.485.4.15, 2002-08-27 12:29:03-07:00, jsimmons@maxwell.earthlink.net
  Added support for logo displaying for new api. Now new code supports 24 bpp.

ChangeSet@1.485.4.14, 2002-08-27 12:14:59-07:00, jsimmons@maxwell.earthlink.net
  More fbdev api cleanups. Removed modename from struct fb_info. Incorporated Paul's fixes. The cfb stuff is finally going away.

ChangeSet@1.485.4.12, 2002-08-20 22:15:23-07:00, jsimmons@maxwell.earthlink.net
  Further api porting. Almost done. Here we eliminate get[set]_cmap from struct fb_ops. Also set_disp has ben moved into fbcon.c instead of the drivers.

ChangeSet@1.485.11.1, 2002-08-19 08:30:12-07:00, jsimmons@maxwell.earthlink.net
  Merge maxwell.earthlink.net:/usr/src/linus-2.5
  into maxwell.earthlink.net:/usr/src/fbdev-2.5

ChangeSet@1.456.25.48, 2002-08-15 21:23:55-07:00, jsimmons@maxwell.earthlink.net
  Ooops. Fix from Paul Mackerras

ChangeSet@1.456.25.47, 2002-08-15 21:05:45-07:00, jsimmons@maxwell.earthlink.net
  Synced up.

ChangeSet@1.456.25.46, 2002-08-14 21:27:21-07:00, jsimmons@maxwell.earthlink.net
  Petr fix to make old api driver to work.

Diffstat output is:

 CREDITS                                |   10
 Documentation/DocBook/kernel-api.tmpl  |    4
 Documentation/fb/README-sstfb.txt      |  173
 Documentation/fb/internals.txt         |    5
 Documentation/fb/sstfb.txt             |  174
 MAINTAINERS                            |    7
 arch/alpha/Kconfig                     |   31
 arch/arm/Kconfig                       |   21
 arch/i386/Kconfig                      |   55
 arch/i386/vmlinux.lds.s                |  114
 arch/ia64/Kconfig                      |   25
 arch/m68k/Kconfig                      |    7
 arch/m68knommu/Kconfig                 |   35
 arch/mips/Kconfig                      |   62
 arch/mips64/Kconfig                    |   23
 arch/parisc/Kconfig                    |   30
 arch/ppc/Kconfig                       |   22
 arch/ppc64/Kconfig                     |    7
 arch/sh/Kconfig                        |   55
 arch/sparc/Kconfig                     |   16
 arch/sparc64/Kconfig                   |   11
 arch/v850/Kconfig                      |   35
 arch/x86_64/Kconfig                    |   55
 drivers/Makefile                       |    3
 drivers/char/Makefile                  |    2
 drivers/char/consolemap.c              |    5
 drivers/char/keyboard.c                |    1
 drivers/char/mem.c                     |   12
 drivers/char/selection.c               |    1
 drivers/char/toshiba.c                 |    2
 drivers/char/tty_io.c                  |    7
 drivers/char/vc_screen.c               |    1
 drivers/char/vt.c                      |  200 -
 drivers/char/vt_ioctl.c                |   58
 drivers/video/68328fb.c                |  967 +----
 drivers/video/Kconfig                  |  411 --
 drivers/video/Makefile                 |   58
 drivers/video/S3triofb.c               |    2
 drivers/video/amifb.c                  |    2
 drivers/video/anakinfb.c               |   62
 drivers/video/atafb.c                  |    2
 drivers/video/aty/atyfb.h              |   18
 drivers/video/aty/atyfb_base.c         |   99
 drivers/video/aty/mach64_ct.c          |    2
 drivers/video/aty/mach64_cursor.c      |  157
 drivers/video/aty/mach64_gx.c          |    2
 drivers/video/aty128fb.c               | 3257 +++++++----------
 drivers/video/cfbcopyarea.c            |  511 +-
 drivers/video/cfbfillrect.c            |  536 ++
 drivers/video/cfbimgblt.c              |  360 +
 drivers/video/chipsfb.c                |    2
 drivers/video/clps711xfb.c             |   16
 drivers/video/console/Kconfig          |  221 +
 drivers/video/console/Makefile         |   61
 drivers/video/console/dummycon.c       |   73
 drivers/video/console/fbcon-sti.c      |  289 +
 drivers/video/console/fbcon.c          | 2846 +++++++++++++++
 drivers/video/console/fbcon.h          |  142
 drivers/video/console/font.h           |   53
 drivers/video/console/font_6x11.c      | 3351 +++++++++++++++++
 drivers/video/console/font_8x16.c      | 4631 ++++++++++++++++++++++++
 drivers/video/console/font_8x8.c       | 2583 +++++++++++++
 drivers/video/console/font_acorn_8x8.c |  277 +
 drivers/video/console/font_mini_4x6.c  | 2158 +++++++++++
 drivers/video/console/font_pearl_8x8.c | 2587 +++++++++++++
 drivers/video/console/font_sun12x22.c  | 6220 +++++++++++++++++++++++++++++++++
 drivers/video/console/font_sun8x16.c   |  275 +
 drivers/video/console/fonts.c          |  142
 drivers/video/console/mdacon.c         |  631 +++
 drivers/video/console/newport_con.c    |  745 +++
 drivers/video/console/prom.uni         |   11
 drivers/video/console/promcon.c        |  605 +++
 drivers/video/console/sti.h            |  289 +
 drivers/video/console/sticon.c         |  214 +
 drivers/video/console/sticore.c        |  601 +++
 drivers/video/console/vgacon.c         | 1066 +++++
 drivers/video/controlfb.c              |  499 --
 drivers/video/cyberfb.c                |    2
 drivers/video/dnfb.c                   |   18
 drivers/video/dummycon.c               |   74
 drivers/video/epson1355fb.c            |    2
 drivers/video/fbcmap.c                 |   92
 drivers/video/fbcon-accel.c            |  188
 drivers/video/fbcon-accel.h            |   34
 drivers/video/fbcon-afb.c              |  448 --
 drivers/video/fbcon-cfb16.c            |  319 -
 drivers/video/fbcon-cfb2.c             |  225 -
 drivers/video/fbcon-cfb24.c            |  333 -
 drivers/video/fbcon-cfb32.c            |  305 -
 drivers/video/fbcon-cfb4.c             |  229 -
 drivers/video/fbcon-cfb8.c             |  294 -
 drivers/video/fbcon-hga.c              |  253 -
 drivers/video/fbcon-ilbm.c             |  296 -
 drivers/video/fbcon-iplan2p2.c         |  476 --
 drivers/video/fbcon-iplan2p4.c         |  497 --
 drivers/video/fbcon-iplan2p8.c         |  534 --
 drivers/video/fbcon-mfb.c              |  217 -
 drivers/video/fbcon-sti.c              |  337 -
 drivers/video/fbcon-vga-planes.c       |  387 --
 drivers/video/fbcon.c                  | 2508 -------------
 drivers/video/fbgen.c                  |  286 -
 drivers/video/fbmem.c                  |  252 -
 drivers/video/fm2fb.c                  |   17
 drivers/video/font_6x11.c              | 3351 -----------------
 drivers/video/font_8x16.c              | 4631 ------------------------
 drivers/video/font_8x8.c               | 2583 -------------
 drivers/video/font_acorn_8x8.c         |  277 -
 drivers/video/font_mini_4x6.c          | 2158 -----------
 drivers/video/font_pearl_8x8.c         | 2587 -------------
 drivers/video/font_sun12x22.c          | 6220 ---------------------------------
 drivers/video/font_sun8x16.c           |  275 -
 drivers/video/fonts.c                  |  135
 drivers/video/g364fb.c                 |   74
 drivers/video/hgafb.c                  |  424 --
 drivers/video/hitfb.c                  |   17
 drivers/video/hpfb.c                   |   16
 drivers/video/iga.h                    |   29
 drivers/video/igafb.c                  |  581 +--
 drivers/video/imsttfb.c                |   41
 drivers/video/macfb.c                  |   22
 drivers/video/macmodes.c               |    3
 drivers/video/macmodes.h               |   70
 drivers/video/matrox/i2c-matroxfb.c    |    2
 drivers/video/matrox/matroxfb_base.c   |    4
 drivers/video/matrox/matroxfb_crtc2.c  |    4
 drivers/video/maxinefb.c               |   48
 drivers/video/mdacon.c                 |  632 ---
 drivers/video/modedb.c                 |    7
 drivers/video/neofb.c                  |  389 +-
 drivers/video/newport_con.c            |  746 ---
 drivers/video/offb.c                   |   23
 drivers/video/platinumfb.c             |  451 --
 drivers/video/pm2fb.c                  |    7
 drivers/video/pm3fb.c                  |    7
 drivers/video/pmag-ba-fb.c             |   59
 drivers/video/pmagb-b-fb.c             |   53
 drivers/video/prom.uni                 |   11
 drivers/video/promcon.c                |  606 ---
 drivers/video/pvr2fb.c                 |    4
 drivers/video/q40fb.c                  |   16
 drivers/video/radeon.h                 |  766 ----
 drivers/video/radeonfb.c               | 3734 +++++++++++--------
 drivers/video/retz3fb.c                |    2
 drivers/video/riva/Makefile            |    2
 drivers/video/riva/accel.c             |  427 --
 drivers/video/riva/fbdev.c             | 2251 +++++------
 drivers/video/riva/fbdev.c.new         | 2036 ++++++++++
 drivers/video/riva/nv_driver.c         |  212 +
 drivers/video/riva/nv_type.h           |   58
 drivers/video/riva/riva_hw.c.new       | 2205 +++++++++++
 drivers/video/riva/riva_hw.h           |    1
 drivers/video/riva/riva_hw.h.new       |  547 ++
 drivers/video/riva/riva_tbl.h.new      | 1008 +++++
 drivers/video/riva/rivafb.h            |   52
 drivers/video/riva/rivafb.h.new        |   54
 drivers/video/sa1100fb.c               |    2
 drivers/video/sbusfb.c                 |    2
 drivers/video/sgivwfb.c                |   62
 drivers/video/sis/Makefile             |    2
 drivers/video/sis/sis_accel.c          |  495 ++
 drivers/video/sis/sis_main.c           |    2
 drivers/video/skeletonfb.c             |   28
 drivers/video/softcursor.c             |   62
 drivers/video/sstfb.c                  |    2
 drivers/video/sti-bmode.h              |  287 -
 drivers/video/sti.h                    |  289 -
 drivers/video/sticon-bmode.c           |  895 ----
 drivers/video/sticon.c                 |  215 -
 drivers/video/sticore.c                |  601 ---
 drivers/video/sticore.h                |  407 ++
 drivers/video/stifb.c                  | 1403 ++++++-
 drivers/video/sun3fb.c                 |    2
 drivers/video/tdfxfb.c                 |  531 +-
 drivers/video/tgafb.c                  |    7
 drivers/video/tridentfb.c              |    2
 drivers/video/tx3912fb.c               |   19
 drivers/video/valkyriefb.c             |   27
 drivers/video/vesafb.c                 |   24
 drivers/video/vfb.c                    |   36
 drivers/video/vga.h                    |  457 --
 drivers/video/vga16fb.c                | 1403 +++++--
 drivers/video/vgacon.c                 | 1055 -----
 drivers/video/vgastate.c               |  503 ++
 drivers/video/virgefb.c                |    2
 include/linux/console.h                |    1
 include/linux/console_struct.h         |    1
 include/linux/fb.h                     |  207 -
 include/linux/pci_ids.h                |   18
 include/linux/radeonfb.h               |   15
 include/linux/sisfb.h                  |   58
 include/linux/vt_kern.h                |    8
 include/video/fbcon-afb.h              |   32
 include/video/fbcon-cfb16.h            |   34
 include/video/fbcon-cfb2.h             |   32
 include/video/fbcon-cfb24.h            |   34
 include/video/fbcon-cfb32.h            |   34
 include/video/fbcon-cfb4.h             |   32
 include/video/fbcon-cfb8.h             |   34
 include/video/fbcon-hga.h              |   32
 include/video/fbcon-ilbm.h             |   32
 include/video/fbcon-iplan2p2.h         |   32
 include/video/fbcon-iplan2p4.h         |   32
 include/video/fbcon-iplan2p8.h         |   32
 include/video/fbcon-mac.h              |   32
 include/video/fbcon-mfb.h              |   32
 include/video/fbcon-vga-planes.h       |   37
 include/video/fbcon-vga.h              |   32
 include/video/fbcon.h                  |  795 ----
 include/video/font.h                   |   53
 include/video/iga.h                    |   24
 include/video/macmodes.h               |   70
 include/video/neomagic.h               |    1
 include/video/radeon.h                 |  766 ++++
 include/video/vga.h                    |  480 ++
 kernel/printk.c                        |    1
 215 files changed, 49572 insertions(+), 49117 deletions(-)




