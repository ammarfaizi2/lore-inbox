Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269804AbRHQHux>; Fri, 17 Aug 2001 03:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269807AbRHQHun>; Fri, 17 Aug 2001 03:50:43 -0400
Received: from cmailg6.svr.pol.co.uk ([195.92.195.176]:281 "EHLO
	cmailg6.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S269804AbRHQHuc>; Fri, 17 Aug 2001 03:50:32 -0400
Date: Fri, 17 Aug 2001 08:49:40 +0100
From: kernel@corrosive.freeserve.co.uk
To: linux-kernel@vger.kernel.org
Subject: Re: SiS 735 chipset
Message-ID: <20010817084939.A873@corrosive.freeserve.co.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <0107102112300E.07809@movitslinux.bloomberg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0107102112300E.07809@movitslinux.bloomberg.com>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux corrosive.freeserve.co.uk 2.4.8-ac1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2001 at 09:12:30PM -0400, Mordechai Ovits wrote:
> 
> Does anyone know if the SiS 735's features, such as IDE, USB, Ethernet and 
> sound are supported by Linux?

Hi,
I've just bought a ECS K7S5A motherboard with this chipset on, and it seems 
to work pretty well so far.  The sound doesn't seem to be supported at 
the moment, but the IDE, USB, and Ethernet(*) seem to be.  I've had a few
'status=0x58' errors when doing some heavy disk activity, but apparently
this can be solved by a kernel option ('use multimode by default') which
I'm about to try (note: these errors only occur when using UDMA as far as I
can tell).  If that doesn't fix it I'll put a question to this list...
The AGP can also be made to work by using 'agp_try_unsupported=1' as a
module/kernel argument.  I'm currently updated the PCI.IDS file and the known
AGP chipset list to include the 735, but I'm checking that the AGP works
fully first.

Cheers,
Adrian.

(*) I can't test the Ethernet properly, but doing 'insmod sis900' works ok,
and the status info it comes back with as it initialises looks reasonable.
Any more than that, I can't verify.


> 
> Thanks,
> Mordy
> -- 
> Mordy Ovits
> Network Engineer
> Bloomberg L.P.

