Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280984AbRLZOlZ>; Wed, 26 Dec 2001 09:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281009AbRLZOlP>; Wed, 26 Dec 2001 09:41:15 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:6666 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280984AbRLZOlF>; Wed, 26 Dec 2001 09:41:05 -0500
Subject: Re: CDROM stop's working 15mins after being mounted
To: Athanasius@gurus.tf (Athanasius)
Date: Wed, 26 Dec 2001 14:50:45 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011226095033.GG4633@gurus.tf> from "Athanasius" at Dec 26, 2001 09:50:33 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16JFOI-00022s-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Only problem I found is when writing TOC (within cdrecord)
> > I have to wait until it finished (I cannot even change console)
> 
>    Ah, I'm not the only one seeing this then.  During the 'fixating'
> stage of burning I see what you describe.  I THINK it's more to do with
> it hogging the bus (for whatever reason), and nothing being able to be
> swapped in.  Could be a total interrupt hog?

The drive doesn't disconnect so it does indeed hog the entire bus. However
for non-X11 consoles a console change doesn't need data off the machine so
it doesnt really explain why that would also fail.
