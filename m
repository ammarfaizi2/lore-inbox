Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130694AbQLLNAl>; Tue, 12 Dec 2000 08:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130685AbQLLNAV>; Tue, 12 Dec 2000 08:00:21 -0500
Received: from smtp03.mrf.mail.rcn.net ([207.172.4.62]:21995 "EHLO
	smtp03.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S130272AbQLLNAH>; Tue, 12 Dec 2000 08:00:07 -0500
Message-ID: <3A361A2F.6BE5D6B0@haque.net>
Date: Tue, 12 Dec 2000 07:29:35 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test12 not liking high disk i/o
In-Reply-To: <Pine.LNX.4.30.0012120650060.9714-100000@viper.haque.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Weird. I just booted from a test12 kernel I compiled (under test11) from
completely clean sources
and tried this again and no problems. I'm just gonna put this down as a
fluke unless someone else someone else sees it or I lockup again.

The only problem I have now is unresolved symbols in some scsi related
modules.

depmod: *** Unresolved symbols in
/lib/modules/2.4.0-test12/kernel/drivers/i2o/i2o_scsi.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.0-test12/kernel/drivers/scsi/aic7xxx.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.0-test12/kernel/drivers/scsi/ide-scsi.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.0-test12/kernel/drivers/scsi/sg.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.0-test12/kernel/drivers/scsi/st.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.0-test12/kernel/drivers/usb/storage/usb-storage.o


"Mohammad A. Haque" wrote:
> 
> If anyone is interested, this is what I am doing before it blows up
> everytime...
> 
> sudo tar zxfv ~mhaque/linux-2.4.0-test5.tar.gz
> cd linux
> cat ~mhaque/kernel-patches/patch-2.4.0-test? ~mhaque/kernel-patches/patch-2.4.0-test1? | sudo patch -p1
> sudo make mrproper
> sudo cp ~/kernel-config .config
> sudo make oldconfig
> sudo make dep bzImage modules modules_install install
> 
> On Tue, 12 Dec 2000, Mohammad A. Haque wrote:
> 
> > Hey guys,
> >
> > Any one else experiencing problems when they do lots of disk activity
> > in test12?
> >

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
