Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317102AbSFFT0Q>; Thu, 6 Jun 2002 15:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317117AbSFFT0P>; Thu, 6 Jun 2002 15:26:15 -0400
Received: from internal-bristol34.naxs.com ([216.98.66.34]:33808 "EHLO
	coredump.electro-mechanical.com") by vger.kernel.org with ESMTP
	id <S317114AbSFFTZ2>; Thu, 6 Jun 2002 15:25:28 -0400
Date: Thu, 6 Jun 2002 15:20:51 -0400
From: William Thompson <wt@electro-mechanical.com>
To: Samuel Flory <sflory@rackable.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PDC20267 + RAID can't find raid device
Message-ID: <20020606152051.H7291@coredump.electro-mechanical.com>
In-Reply-To: <20020606111918.F7291@coredump.electro-mechanical.com> <1023391095.3423.112.camel@flory.corp.rackablelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   It works for me once I got the right options.  Did you enable the
> "fasttrak feature"
> 
> I'm using the following options in my .config:
> CONFIG_BLK_DEV_PDC202XX=y
> CONFIG_PDC202XX_BURST=y
> CONFIG_PDC202XX_FORCE=y
> CONFIG_BLK_DEV_ATARAID_PDC=y

Only difference is the fact I didn't enable BURST.  your other 3 options are
the same as mine.

The thing says:
Promise Fasttrak(tm) Softwareraid driver 0.03beta: No raid array found

> /dev/ataraid/d0 devices, and the /dev/hd devices.  This makes for lots
> of fun in the Red Hat installer, and Cerberus.   

I'm using debian, but I'm not actually installing the system, I'm copying
from another.

> > After trying 2.4.19-pre10-ac2 I can finally use the PDC20267 controller,
> > however, it doesn't find any raid devices.
> > 
> > I have 2 quantum fireballlct10 05 on the controller (hde and hdg) and
> > created a stripe between these 2 disks in the controller's bios.
> > 
> > I can see both disks w/o problems.
> > 
> > I'd rather not use the linux software raid since you can't partition it.
> > 
> > IDE, PDC20267, FastTrak, and the raid driver are all compiled into the
> > kernel.
> > 
> > More info is available at request.
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> 
> 
