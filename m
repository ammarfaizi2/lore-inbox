Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317686AbSFLLKC>; Wed, 12 Jun 2002 07:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317683AbSFLLKA>; Wed, 12 Jun 2002 07:10:00 -0400
Received: from grobbebol.xs4all.nl ([194.109.248.218]:55904 "EHLO
	grobbebol.xs4all.nl") by vger.kernel.org with ESMTP
	id <S317464AbSFLLJ7>; Wed, 12 Jun 2002 07:09:59 -0400
Date: Wed, 12 Jun 2002 11:09:38 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: Oliver Eikemeier <eikemeier@fillmore-labs.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: via ide udma & ibm hd freezes kernel
Message-ID: <20020612110938.A10335@grobbebol.xs4all.nl>
In-Reply-To: <00d901c208a0$0bd9ae00$fa82a8c0@atlantis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-OS: Linux grobbebol 2.4.18 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2002 at 02:38:20PM +0200, Oliver Eikemeier wrote:
> Hi,
> 
> I'm using SuSE Linux 8.0 with a 2.4.18 kernel, and a machine with a VIA vt82c686b southbridge. The system runs very stable with only one (Western Digital) hard disk on ide bus 0, but when I add a second (IBM) hard disk configured as slave, the kernel freezes when I'm accessing the second disk (after *some accesses, i.e. when I can copy 10 small files on it, it freezes on the third). I read the mailing list, lost of people seem to have problems with this configuration, but most advices are to change the cable, which I did.
> 
> Symptoms are: the hard disk LED is on, the machine freezes (no blinking cursor on the text console, no remote access) or the caps lock & scroll lock LEDs on the keyboard flash, same lockup.

I see these symptoms only when I make the awful mistake to use the
nvidia drivers.

if I ditch them, all goes fine..

-- 
Grobbebol's Home                        |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel            | Use your real e-mail address   /\
Linux 2.4.18  UP 1200MHz celeron/768 MB |        on Usenet.             _\_v  
