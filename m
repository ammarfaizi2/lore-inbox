Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315748AbSECXYH>; Fri, 3 May 2002 19:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315749AbSECXYG>; Fri, 3 May 2002 19:24:06 -0400
Received: from vger.timpanogas.org ([216.250.140.154]:50118 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S315748AbSECXYF>; Fri, 3 May 2002 19:24:05 -0400
Date: Fri, 3 May 2002 16:47:16 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Jason Giglio <jgiglio@vt.edu>
Cc: linux-kernel@vger.kernel.org, bradlist@bradm.net
Subject: Re: 3ware 7810 and Tyan 2462 Tiger MP lockup
Message-ID: <20020503164716.A24392@vger.timpanogas.org>
In-Reply-To: <20020503190809.7cb8c052.jgiglio@vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



There is a firmware upgrade 3Ware is (or has) posted regarding
this lockup problem.  They had identified the problem, and I believe
the most recent firmware posted to their site corrects it.  You 
should upgrade the firmware and retest the system.

Jeff

On Fri, May 03, 2002 at 07:08:09PM -0400, Jason Giglio wrote:
> Bradley McLean had posted a while back (3/30/02) about problems with 3ware 7810 cards and Tyan Tiger MP.  He had indicated that updating his drivers and changing a PCI riser card around fixed the problem.
> 
> I have recently encountered the problem with the newest drivers and no PCI riser cards.  It only seems to happen when using XFS, and when directly accessing the 3ware card through /dev/sda.  The symptoms are the same, hard lockup, no ping, no nothing, during heavy I/O. An added twist is that the file system is very corrupt upon rebooting.
> 
> I have sent a message to the XFS list, but I thought I'd drop a note in here that the problem is still persisting, since it is not likely a problem in XFS proper that is causing the initial lockup, considering that others had the problem with any file system previously.  It was suggested by Alan Cox that this may be an APIC issue, it happened for me with or without noapic specified.
> 
> Please CC me on replies to list.  
> 
> Thanks,
> Jason
> 
> >From: Bradley McLean (bradlist@bradm.net)
> >Subject: Hard hang on 3Ware7850, Dual AthlonMP, Tyan2462
> 
> >I've been following the various discussions of athlon MP problems. We too have systems that consistently hard lock up.
> >Running RH7.2 with kernel.org kernels, versions 2.4.17, 2.4.18,
> >or 2.4.18 plus the IO-APIC patch posted for 2.4.19pre3.
> >Using the latest (release 7.4, driver version 19) 3ware code. Tyan 2462, 3.5 GB
> >(2) AMD MP1900+
> >(6) WB1200JB Symptoms:  Either under heavy read, or heavy write, system locks up.  No ping, no keyboard.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
