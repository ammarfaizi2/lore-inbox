Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265426AbSKSN7E>; Tue, 19 Nov 2002 08:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265446AbSKSN7E>; Tue, 19 Nov 2002 08:59:04 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:40452 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S265426AbSKSN7D>; Tue, 19 Nov 2002 08:59:03 -0500
Message-ID: <3DDA4561.52B00494@aitel.hist.no>
Date: Tue, 19 Nov 2002 15:06:25 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.47 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: CaT <cat@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.48 and ALSA
References: <20021119133959.GA818@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CaT wrote:
> 
> Is it supposed to work when compiled into the kernel? I have it compiled

Yes, it used to work.  I have sometimes had to help the boot
scripts as the "gave up" when modprobe failed.  But
it always worked after setting up the mixer manually.

Sometime before 2.5.47 ALSA broke, at least for trident.
I haven't tested if it works with modules - if it don't
work compiled-in it don't work for me.  I don't get all the devices
either.

> with OSS emulation and it worked as modules with 2.5.47 but not compiled
> in to 2.5.48 (trying to avoid the whole modules changes here :)

Yes, and also avoiding the maintenance of modules.conf, extra
devfs issues, and so on for only a little extra memory.

Helge Hafting
