Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130002AbRBLCUh>; Sun, 11 Feb 2001 21:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130341AbRBLCUR>; Sun, 11 Feb 2001 21:20:17 -0500
Received: from vp175097.reshsg.uci.edu ([128.195.175.97]:14860 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S130002AbRBLCUJ>; Sun, 11 Feb 2001 21:20:09 -0500
Date: Sun, 11 Feb 2001 18:20:00 -0800
Message-Id: <200102120220.f1C2K0I00489@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: Rogerio Brito <rbrito@iname.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Slowing down CDROM drives
In-Reply-To: <20010211162047.A1003@iname.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.18 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Feb 2001 16:20:47 -0200, Rogerio Brito <rbrito@iname.com> wrote:

>> > 	ioctl(cd_fd, CDROM_SELECT_SPEED, speed);

Yes: pass 0 as the speed, in the ioctl() above.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
