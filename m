Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273801AbRIRBat>; Mon, 17 Sep 2001 21:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273799AbRIRBaj>; Mon, 17 Sep 2001 21:30:39 -0400
Received: from trantor.dso.org.sg ([192.190.204.1]:29868 "EHLO
	trantor.dso.org.sg") by vger.kernel.org with ESMTP
	id <S273800AbRIRBac>; Mon, 17 Sep 2001 21:30:32 -0400
Date: Tue, 18 Sep 2001 09:31:11 +0800
From: Richard Shih-Ping Chan <cshihpin@dso.org.sg>
To: linux-kernel@vger.kernel.org
Message-ID: <20010918093111.A12534@cshihpin.dso.org.sg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bcc: 
Subject: Re: Athlon: Try this (was: Re: Athlon bug stomping #2)
Reply-To: 
In-Reply-To: <a05100300b7cbbff304d5@[192.168.239.101]>; from chromi@cyberspace.org on Mon, Sep 17, 2001 at 03:59:15PM +0100

A me-too message - I'd like to report success with the 55.7 Athlon bug stomper
on a Soltek 75KAV-X mobo (using KT133A).

Before the patch byte 55 is 0x89, and the kernel oopses at init or usb probing.
After the patch byte 55 is 0x09 and everything works.


On Mon, Sep 17, 2001 at 03:59:15PM +0100, Jonathan Morton wrote:
> >  > ... but there are listed both KT133 and KT133A based motherboards,
> >>  so maybe it is intentional?
> >
> >The same south bridge is used for both the KT133 and the KT133A.
> 
> And also for other northbridges.  I've seen the 82c686a used on an 
> i810 board, which is currently in my friend's games machine.
> 
> -- 
> --------------------------------------------------------------
> from:     Jonathan "Chromatix" Morton
> mail:     chromi@cyberspace.org  (not for attachments)
> website:  http://www.chromatix.uklinux.net/vnc/
> geekcode: GCS$/E dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$
>            V? PS PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
> tagline:  The key to knowledge is not to rely on people to teach you it.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Richard Chan <cshihpin@dso.org.sg>
DSO National Laboratories
20 Science Park Drive
Singapore 118230
Tel: 7727045
Fax: 7766476
