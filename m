Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280061AbRKITmJ>; Fri, 9 Nov 2001 14:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280087AbRKITl7>; Fri, 9 Nov 2001 14:41:59 -0500
Received: from pc3-redb4-0-cust118.bre.cable.ntl.com ([213.106.223.118]:33014
	"HELO opel.itsolve.co.uk") by vger.kernel.org with SMTP
	id <S280061AbRKITlq>; Fri, 9 Nov 2001 14:41:46 -0500
Date: Fri, 9 Nov 2001 19:41:42 +0000
From: Mark Zealey <mark@zealos.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Lockup in IDE code
Message-ID: <20011109194142.A25361@itsolve.co.uk>
In-Reply-To: <200111090217.fA92HYh00521@vindaloo.ras.ucalgary.ca> <1005299137.13841.27.camel@nomade> <200111091656.fA9GusD06947@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <200111091656.fA9GusD06947@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Fri, Nov 09, 2001 at 09:56:54AM -0700
X-Operating-System: Linux sunbeam 2.2.19 
X-Homepage: http://zealos.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2001 at 09:56:54AM -0700, Richard Gooch wrote:

> GXavier Bestel writes:
> > le ven 09-11-2001 à 03:17, Richard Gooch a écrit :
> > >   Hi, all. I tried to use my IDE CD-ROM today, the first time in a
> > > long while. When attempting to mount it, the machine locked up,
> > > hard. Even SysReq didn't work.
> > 
> > Do you have a read error on your CD ?
> 
> No. I did mention that when I turned off DMA, it worked fine.
> 
> BTW: I've gotten a few "helpful" responses saying "try using hdparm to
> turn off DMA". Well, those people obviously hadn't bothered reading
> all my message, because I stated that when I disabled DMA with hdparm,
> it worked fine.
> </grumble>

Well, obviously your drive or mobo doesn't support DMA. I noticed that all the
other devices (hd[acd]) were in PIO mode, why not try setting dma mode on one of
them. Most CD's I've come across don't do DMA very well, I believe that the DMA
is mostly only useful for DVD's, where you need a high transfer rate to watch a
movie.

-- 

Mark Zealey
mark@zealos.org
mark@itsolve.co.uk

UL++++>$ G!>(GCM/GCS/GS/GM) dpu? s:-@ a16! C++++>$ P++++>+++++$ L+++>+++++$
!E---? W+++>$ N- !o? !w--- O? !M? !V? !PS !PE--@ PGP+? r++ !t---?@ !X---?
!R- b+ !tv b+ DI+ D+? G+++ e>+++++ !h++* r!-- y--

(www.geekcode.com)
