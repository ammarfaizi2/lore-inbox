Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274752AbRJNIJI>; Sun, 14 Oct 2001 04:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274789AbRJNII7>; Sun, 14 Oct 2001 04:08:59 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:33421 "EHLO ookhoi.xs4all.nl")
	by vger.kernel.org with ESMTP id <S274752AbRJNIIo>;
	Sun, 14 Oct 2001 04:08:44 -0400
Date: Sun, 14 Oct 2001 10:09:05 +0200
From: Ookhoi <ookhoi@dds.nl>
To: Alexander Viro <viro@math.psu.edu>
Cc: Ed Tomlinson <tomlins@CAM.ORG>, linux-kernel@vger.kernel.org
Subject: Re: mount hanging 2.4.12
Message-ID: <20011014100905.D30428@humilis>
Reply-To: ookhoi@dds.nl
In-Reply-To: <20011014015115.E894D11718@oscar.casa.dyndns.org> <Pine.GSO.4.21.0110132201150.3903-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0110132201150.3903-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.19i
X-Uptime: 12:53:32 up 5 days, 16:11,  9 users,  load average: 0.08, 0.02, 0.01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >> He said in his original email that it was a USB SmartMedia reader,
> > >> which reads the SmartMedia cards used with FujiFilm digital cameras
> > >> (amongst others). The actual file system is determined by the cards
> > >> themselves and can't be changed.
> > 
> > >Ahem.  Which fs driver is used when it's successfully mounted?
> > 
> > fat.  Would an strace help?
> 
> It might, but another thing I'd like to see is stack trace of hung mount.

I have the same with sony memorystick. Load usb/scsi/fat modules, mount,
umount, mount again but it fails. I just unload and load all the
relevant modules again and I can read the stick again. This is with
2.4.6-ac2 for example.

	Ookhoi
