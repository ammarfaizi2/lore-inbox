Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288515AbSADHIx>; Fri, 4 Jan 2002 02:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288518AbSADHIn>; Fri, 4 Jan 2002 02:08:43 -0500
Received: from lsr-net2.nei.nih.gov ([128.231.132.10]:27809 "HELO
	lsr.nei.nih.gov") by vger.kernel.org with SMTP id <S288515AbSADHI2>;
	Fri, 4 Jan 2002 02:08:28 -0500
Date: Fri, 4 Jan 2002 02:06:57 -0500 (EST)
From: Art Hays <art@lsr.nei.nih.gov>
X-X-Sender: <art@lsr-linux>
To: <linux-kernel@vger.kernel.org>
Subject: Re: kswapd etc hogging machine
In-Reply-To: <E16M72b-0008B8-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0201040201190.3437-100000@lsr-linux>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


An update:  This particular behavior I observed no longer occurs with
2.4.9-13smp, the latest update supplied by Redhat.  Thanks for all the
very helpful info I received.

> Problem:  kswapd, kreclaimd, kupdated push load average high during simple
> tar.  Response of system drops such that even keystroke echos are
> noticeably delayed.
> 
> Specifics:
> 
> Machine- 4 processor 700Mhz Dell with 4G Ram and 6G swap space running
> stock Redhat 7.2 distribution.  All disks are SCSI using ext2.
> 
> Command- from a remote machine this command is executed to the Linux 
> machine "tar cBf - . | rsh linux "(tar xBpf -)".
> 
> Manifestion of problem- As this command continues on a freshly booted 
> Linux machine the free memory reported by 'top' slowly goes to a low 
> number.  When it bottoms out, the processes 'kswapd', 'kreclaimd', and 
> 'kupdated' begin to run pushing the load average above 4 at times.  
> Responsiveness of machine drops dramatically with even keystroke echos 
> delayed for seconds.


-- 
Art Hays					avhays@nih.gov or art@lsr.nei.nih.gov
Bldg 49 Rm 2A50					(301) 496-7143 (voice)
Nat. Institutes of Health			(301) 402-0511 (fax)
Bethesda, MD  20892


