Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279885AbRKBBCA>; Thu, 1 Nov 2001 20:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279886AbRKBBBu>; Thu, 1 Nov 2001 20:01:50 -0500
Received: from smtp-rt-7.wanadoo.fr ([193.252.19.161]:50312 "EHLO
	embelia.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S279885AbRKBBBd> convert rfc822-to-8bit; Thu, 1 Nov 2001 20:01:33 -0500
Message-ID: <3BE242B0.1010400@free.fr>
Date: Fri, 02 Nov 2001 01:52:32 -0500
From: FORT David <popo.enlighted@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011012
X-Accept-Language: fr, en-us
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Oops on 2.4.13
In-Reply-To: <1235.1004655139@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:

>On Thu, 01 Nov 2001 16:45:04 -0500, 
>FORT David <popo.enlighted@free.fr> wrote:
>
>>the kernel is tainted but by a kernel driver which hasn't set
>>any licence(can't remember which one)
>>
>
>modinfo `modprobe -l` | sed -ne '/^filename/h; /^license.*none/{g;p;}'
>
>lists all modules without a license, please report so it can be fixed.
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
Looks like there's many candidates, and some quite commonly
used modules:
filename:    /lib/modules/2.4.13/kernel/drivers/block/loop.o
filename:    /lib/modules/2.4.13/kernel/drivers/media/video/cpia.o
filename:    /lib/modules/2.4.13/kernel/drivers/media/video/cpia_usb.o
filename:    /lib/modules/2.4.13/kernel/drivers/media/video/mod_quickcam.o
filename:    /lib/modules/2.4.13/kernel/drivers/net/pppoe.o
filename:    /lib/modules/2.4.13/kernel/drivers/net/pppox.o
filename:    
/lib/modules/2.4.13/kernel/drivers/video/matrox/matroxfb_crtc2.o
filename:    /lib/modules/2.4.13/kernel/drivers/video/matrox/matroxfb_g450.o
filename:    
/lib/modules/2.4.13/kernel/drivers/video/matrox/matroxfb_maven.o
filename:    /lib/modules/2.4.13/kernel/drivers/video/matrox/matroxfb_misc.o
filename:    /lib/modules/2.4.13/kernel/fs/coda/coda.o
filename:    /lib/modules/2.4.13/kernel/fs/msdos/msdos.o
filename:    /lib/modules/2.4.13/kernel/fs/nfs/nfs.o
filename:    /lib/modules/2.4.13/kernel/fs/nls/nls_big5.o
filename:    /lib/modules/2.4.13/kernel/fs/nls/nls_cp936.o
filename:    /lib/modules/2.4.13/kernel/fs/nls/nls_cp950.o
filename:    /lib/modules/2.4.13/kernel/fs/nls/nls_gb2312.o
filename:    /lib/modules/2.4.13/kernel/fs/nls/nls_iso8859-1.o
filename:    /lib/modules/2.4.13/kernel/fs/nls/nls_iso8859-15.o
filename:    /lib/modules/2.4.13/kernel/fs/nls/nls_iso8859-2.o
filename:    /lib/modules/2.4.13/kernel/fs/nls/nls_iso8859-4.o
filename:    /lib/modules/2.4.13/kernel/fs/nls/nls_utf8.o
filename:    /lib/modules/2.4.13/kernel/fs/vfat/vfat.o
filename:    /lib/modules/2.4.13/kernel/net/khttpd/khttpd.o
filename:    /lib/modules/2.4.13/kernel/net/netlink/netlink_dev.o


-- 
%-------------------------------------------------------------------------%
% FORT David,                                                  0668373331 %
% 5 boulevard de solférino                                     0299679330 %
% 35000 Rennes, France                             popo.enlighted@free.fr %
% ICU:78064991                                   david.fort@intranode.com %
%--LINUX-HTTPD-PIOGENE----------------------------------------------------%
%  -datamining <-/                        |   .~.                         %
%  -networking/PHP/java/JSPs              |   /V\        L  I  N  U  X    %
%  -opensource                            |  // \\     >Fear the Penguin< %
%  -GNOME/enlightenment/GIMP              | /(   )\                       %
%           feel enlightened....          |  ^^-^^                        %
%                              HomePage: http://www.enlightened-popo.net  %
%---------- -- This was sent by Djinn running Linux 2.4.13 -- ------------%



