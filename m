Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284973AbRLKLSR>; Tue, 11 Dec 2001 06:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284972AbRLKLR6>; Tue, 11 Dec 2001 06:17:58 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:62468 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S284969AbRLKLR5>; Tue, 11 Dec 2001 06:17:57 -0500
Date: Tue, 11 Dec 2001 12:17:54 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: John Huttley <john@mwk.co.nz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.16 Bug] major failure
Message-ID: <20011211121754.E4618@emma1.emma.line.org>
Mail-Followup-To: John Huttley <john@mwk.co.nz>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1008054620.1453.0.camel@albatross.hisdad.org.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1008054620.1453.0.camel@albatross.hisdad.org.nz>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2001, John Huttley wrote:

> I wish to report a major failure.
> with 2.4.16 and 2.4.17-pre8
> on PII-450 x2 SMP system, Gigabyte BXDS board
> (has adaptec scsi chip on it)
> using IDE disk, scsi tape (DDS-4)
> 
> My system boots to X.
> I swap to VC1 and start tarring up a lot of mp3's.
> 
> It works fine if i leave it to complete.
> 
> If I go to X and then back to VC1, the system will lock solid.
> No num lock, no magic sysreq, no ping.

If it wasn't for SMP, I'd say try to boot with "disableapic", but I have
no clues whether this will break SMP or wreak other havoc. 

At least, since around 2.4.10, booting my Uniprocessor Duron on a
Gigabyte 7ZXR board breaks at the same occasion. At the time I reported
that, I was told to take this to the XFree guys, then that IOAPIC stuff
on UP was unstable. 

I tend to believe that some bug sneaked in around those 2.4.10 versions.

Can you tell what kernel versions were the last that work OK for you
when switching from X11 to virtual console?

(Remeber to Cc: John Huttley on replies, he said he's not on the list.)

