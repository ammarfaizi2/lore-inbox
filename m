Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311884AbSE1Nio>; Tue, 28 May 2002 09:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312457AbSE1Nin>; Tue, 28 May 2002 09:38:43 -0400
Received: from fep02.tuttopmi.it ([212.131.248.101]:25594 "EHLO
	fep02-svc.flexmail.it") by vger.kernel.org with ESMTP
	id <S311884AbSE1Nin>; Tue, 28 May 2002 09:38:43 -0400
Subject: Re: Kernel (2.4.19-pre8) hang
From: Frederik Nosi <fredi@e-salute.it>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 28 May 2002 15:41:23 +0200
Message-Id: <1022593284.1732.22.camel@linux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now it happened again:
While I was using the pc with KDE, Evolution, Opera, Quanta+, Apache
(with only 3 processes for serving, limited by me) && MySQL so with a
lot of workload while opera was getting a page (presumably writting to
disk) the pc hangs. I can ping but I'have not any ssh or similar to get
a shell. Obviously I found ports 80, 443 and 3306(mysql) opened. I tryed
to connect with a browser and apache says no authorysation but I have
setted it to accept connections from all (probably apache cant read from
disk), while mysql crashed. I notice it because the mysql tcp port was
closed.

Now if you want me to try something else, I'll wait 2/3 hours for a 
mail. After that I'll reboot that pc hopping that my partitions arent
wihpped :)

If you have any suggestion, patch, test, request info I'll be happy to
fullfill it. Expecially sugestions on how make work at last for some
other time my hd if it is doable :)
Now Im really thinking that it is a hardware problem :(

Please CC me
Frederik Nosi

Il lun, 2002-05-27 alle 23:24, Alan Cox ha scritto:
> On Mon, 2002-05-27 at 20:24, Frederik Nosi wrote:
> > May 27 18:28:13 linux kernel: EXT3-fs error (device ide0(3,7)):
> > ext3_free_blocks: bit already cleared for block 215665
> >
> > I suspect at my hd too but for being sure... Please CC me because I'm
> > not subscribed to the list and excuse me for my bad english and the long
> > mail.
>
> What mode is your hard disk reported to be in. If it is using UDMA then
> its very unlikely to be the disk itself. We also should now have all the
> needed workarounds for VIA chipset bugs.
> Has this box been stable with older kernels ?
I think so
>
> Alan
>
Thank you for your time,
Fredi. 

