Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261390AbSKBSub>; Sat, 2 Nov 2002 13:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261391AbSKBSua>; Sat, 2 Nov 2002 13:50:30 -0500
Received: from signup.localnet.com ([207.251.201.46]:2202 "HELO
	smtp.localnet.com") by vger.kernel.org with SMTP id <S261390AbSKBSu1>;
	Sat, 2 Nov 2002 13:50:27 -0500
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: qconf buglet
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <Pine.LNX.4.44.0211021543070.6949-100000@serv>
Date: 02 Nov 2002 13:56:42 -0500
Message-ID: <m3fzuj3imt.fsf_-_@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just gave qconf a try in a clone of bk://linux.bkbits.net/linux-2.5
pulled up to ChangeSet@1.872, 2002-11-01 20:51:14-08:00, torvalds@home.transmeta.com

Fonts did not display at all until I ran it with QT_XFT=0.

It may be reasonable to force that.

Box started as suse 7.3; has qt-2.3.2 and has xft1 from
fontconfig-1.0.1.  ldd(1) on qconf shows:

        libqt-mt.so.2 => /usr/lib/qt2/lib/libqt-mt.so.2 (0x40016000)
        libdl.so.2 => /lib/libdl.so.2 (0x404f3000)
        libstdc++-libc6.2-2.so.3 => /usr/lib/libstdc++-libc6.2-2.so.3 (0x404f7000)
        libm.so.6 => /lib/libm.so.6 (0x40544000)
        libc.so.6 => /lib/libc.so.6 (0x40566000)
        libpthread.so.0 => /lib/libpthread.so.0 (0x4068c000)
        libGLU.so.1 => /usr/lib/libGLU.so.1 (0x406a3000)
        libGL.so.1 => /usr/lib/libGL.so.1 (0x4072c000)
        libXmu.so.6 => /usr/X11R6/lib/libXmu.so.6 (0x40795000)
        libXext.so.6 => /usr/X11R6/lib/libXext.so.6 (0x407ab000)
        libX11.so.6 => /usr/X11R6/lib/libX11.so.6 (0x407b9000)
        libSM.so.6 => /usr/X11R6/lib/libSM.so.6 (0x40879000)
        libICE.so.6 => /usr/X11R6/lib/libICE.so.6 (0x40883000)
        libXft.so.1 => /usr/X11R6/lib/libXft.so.1 (0x4089b000)
        libpng.so.2 => /usr/lib/libpng.so.2 (0x408a9000)
        libz.so.1 => /lib/libz.so.1 (0x408db000)
        libjpeg.so.62 => /usr/lib/libjpeg.so.62 (0x408ea000)
        libmng.so.1 => /usr/lib/libmng.so.1 (0x40909000)
        /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x40000000)
        libXt.so.6 => /usr/X11R6/lib/libXt.so.6 (0x4094a000)
        libXrender.so.1 => /usr/X11R6/lib/libXrender.so.1 (0x40997000)
        libfontconfig.so.1 => /usr/lib/libfontconfig.so.1 (0x4099e000)
        libfreetype.so.6 => /usr/lib/libfreetype.so.6 (0x409c4000)
        liblcms.so.1 => /usr/lib/liblcms.so.1 (0x40a13000)
        libexpat.so.0 => /usr/lib/libexpat.so.0 (0x40a24000)

-JimC

