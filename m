Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWBMQoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWBMQoM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 11:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWBMQoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 11:44:12 -0500
Received: from mail.gmx.net ([213.165.64.21]:21892 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932156AbWBMQoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 11:44:10 -0500
X-Authenticated: #428038
Date: Mon, 13 Feb 2006 17:44:06 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060213164406.GG15889@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <43EC71FB.nailISD31LRCB@burner> <20060210114930.GC2750@DervishD> <43EC88B8.nailISDH1Q8XR@burner> <43EFC1FF.7030103@vilain.net> <43F097AE.nailKUSK1MJ9O@burner> <BAYC1-PASMTP10B5F649DEDADD145E56BDAE070@CEZ.ICE> <20060213095038.03247484.seanlkml@sympatico.ca> <43F0A771.nailKUS131LLIA@burner> <mj+md-20060213.160108.13290.atrey@ucw.cz> <43F0B32D.nailKUS1E3S8I3@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F0B32D.nailKUS1E3S8I3@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-02-13:

> Martin Mares <mj@ucw.cz> wrote:
> 
> > Hello!
> >
> > > If there is no interest to fox well known bugs in Linux, I would need to warn
> > > people from using Linux.
> >
> > Except for mentioning some DMA related problems at the beginning of this
> > monstrous thread, you haven't shown anything which even remotely qualifies
> > as a bug.
> 
> If you forget these things, then please forget about this thread.
> 
> I mentioned:
> 
> -	ide-scsi does not do DMA correctly

Apparently no-one bothers to fix this with ide-cd supporting SG_IO, and
nobody produced any use case for other ide-*.c devices.

You'll either have to fix this yourself or wait until the day the cows
coime home.

> -	SCSI commands are bastardized on ATAPI 

You were asked for a proof but didn't provide one. If you think
otherwise, post URL or Message-ID. We're all sooooooooooooooo terrible
forgetful we don't recall your reports from 2001.

-- 
Matthias Andree
