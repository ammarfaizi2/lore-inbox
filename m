Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbTIENlN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 09:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262698AbTIENlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 09:41:13 -0400
Received: from [203.185.132.124] ([203.185.132.124]:23180 "EHLO mrchoke.com")
	by vger.kernel.org with ESMTP id S262732AbTIENlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 09:41:09 -0400
Message-ID: <3F589256.3000508@opentle.org>
Date: Fri, 05 Sep 2003 20:40:38 +0700
From: Supphachoke Suntiwichaya <mrchoke@opentle.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030413
X-Accept-Language: th,en-us, en
MIME-Version: 1.0
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22-bk10 and ALSA 0.9.6
References: <20030905130007.GE9634@rdlg.net>
In-Reply-To: <20030905130007.GE9634@rdlg.net>
Content-Type: text/plain; charset=TIS-620; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert L. Harris wrote:

>I've been using Alsa 0.9.6 for the last few kernels and it has been
>working great.  I just tried to install it on the 2.4.22-bk10 kernel
>with the same Configure command as always:
>
>./configure --with-oss=yes --with-kernel=/usr/src/kernels/2.4.22/Desktop/linux-2.4.22/ \
>--with-cards=dummy,virmidi,serial-u16550,mtpav,mpu401,als100,azt2320,cmi8330,dt019x,es18xx,opl3sa2,sgalaxy,sscape,ad1816a,ad1848,cs4231,cs4232,cs4236,es1688,gusclassic,gusmax,gusextreme,interwave,interwave-stb,opti92x-ad1848,opti92x-cs4231,opti93x,sb8,sb16,sbawe,es968,wavefront,als4000,azt3328,cmipci,cs4281,ens1370,ens1371,es1938,es1968,fm801,intel8x0,maestro3,rme32,rme96,sonicvibes,via82xx,ali5451,cs46xx,emu10k1,ice1712,ice1724,korg1212,nm256,rme9652,hdsp,trident,vx222,ymfpci,powermac,sa11xx-uda1341,usb-audio,harmony,vxpocket,vxp440,pdplus,mixart,msnd-pinnacle,pdaudiocf
>
>(building a distribution kernel for multiple desktops)
>
>I get this:
>
>make[1]: Entering directory
>`/exp/src1/kernels/2.4.22/Desktop/alsa-driver-0.9.6/acore'
>gcc -D__KERNEL__ -DMODULE=1
>-I/exp/src1/kernels/2.4.22/Desktop/alsa-driver-0.9.6/include
>-I/usr/src/kernels/2.4.22/Desktop/linux-2.4.22//include -O2
>-mpreferred-stack-boundary=2 -march=i586 -DLINUX -Wall
>-Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2
>-fno-strict-aliasing -fno-common -pipe -DALSA_BUILD   -DEXPORT_SYMTAB -c
>hwdep.c
>In file included from
>/exp/src1/kernels/2.4.22/Desktop/alsa-driver-0.9.6/include/sound/driver.h:42,
>                 from hwdep.c:22:
>/exp/src1/kernels/2.4.22/Desktop/alsa-driver-0.9.6/include/adriver.h:200:
>redefinition of `irqreturn_t'
>/usr/src/kernels/2.4.22/Desktop/linux-2.4.22/include/linux/interrupt.h:16:
>`irqreturn_t' previously declared here
>make[1]: *** [hwdep.o] Error 1
>make[1]: Leaving directory
>`/exp/src1/kernels/2.4.22/Desktop/alsa-driver-0.9.6/acore'
>make: *** [compile] Error 1
>
>:wq!
>

o.k.. use lastest ALSA CVS version...

MrChoke


-- 

Name : Supphachoke Suntiwichaya
Email : MrChoke@opentle.org
URL : http://jedi.links.nectec.or.th/mrchoke/
Distribution : Linux TLE 5.0 (Andaman)
OS : Linux 2.4.22-rc2-ac3 #1 ¾Ä. Ê.¤. 21 18:51:09 ICT 2003 i686 GNU/Linux
Uptime :  20:35:00  up 2 days,  7:05,  2 users,  load average: 1.00, 1.00, 1.00


