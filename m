Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129075AbRBOQwm>; Thu, 15 Feb 2001 11:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129104AbRBOQwc>; Thu, 15 Feb 2001 11:52:32 -0500
Received: from cold.fortyoz.org ([64.40.111.214]:31762 "HELO cold.fortyoz.org")
	by vger.kernel.org with SMTP id <S129075AbRBOQwA>;
	Thu, 15 Feb 2001 11:52:00 -0500
Date: Thu, 15 Feb 2001 08:52:38 -0800
From: David Raufeisen <david@fortyoz.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.1ac14
Message-ID: <20010215085238.A14932@fortyoz.org>
Reply-To: David Raufeisen <david@fortyoz.org>
In-Reply-To: <E14TPQH-0008GV-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <E14TPQH-0008GV-00@the-village.bc.nu>; from "Alan Cox" on Thursday, 15 February 2001, at 14:30:15 (+0000)
X-Operating-System: Linux 2.2.17 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After building/playing around with some java apps on this version, something
seems to have gone weird with X or the kernel..

david@prototype:~$ ps aux | grep X
root       267  0.9 99.9 167640 4294965764 ? S<   06:50   1:11 /usr/bin/X11/X vt7 -auth /var/lib/gdm/:0.Xauth :0

System seems mostly fine, a bit slow..

Nothing special in logs

prototype:~# free
             total       used       free     shared    buffers     cached
Mem:        126708     123856       2852          0      27836      71568
-/+ buffers/cache:      24452     102256
Swap:       554232      66596     487636

Would having the huge swap have anything to do with it? Needed it to install
oracle, but the blasted thing won't install anyway (Debian Sid).

On Thursday, 15 February 2001, at 14:30:15 (+0000),
Alan Cox wrote:

> 
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/alan/2.4/
> 
> 2.4.1-ac14
> o	Fix tulip problems introduced by in ac13	(Manfred Spraul)
> o	S/390x build fixes				(Ulrich Weigand)
> o	Fix off by one error in octagon driver		(David Woodhouse)
> o	Fix dasd driver for new queues			(Holger Smolinksi)
> o	Networking standards compliance fixes
> o	Fix binary layout assumptions in sym53c416	(Arjan van de Ven)
> o	tmpfs timestamps				(Christoph Rohland)
> o	Further mkdep changes				(Keith Owens)
> o	Fix 16bit vfat handling				(OGAWA Hirofumi)
> o	JIS nls fixes					(OGAWA Hirofumi)
> o	Handle more than 8 luns				(Eric Youngdale,
> 							 Doug Gilbert)
> o	Minor scsi clean ups				(Eric Youngdale)
