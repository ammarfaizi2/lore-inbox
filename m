Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030287AbWBMXc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287AbWBMXc5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 18:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030283AbWBMXc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 18:32:57 -0500
Received: from smtp.enter.net ([216.193.128.24]:36367 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1030287AbWBMXcz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 18:32:55 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Mon, 13 Feb 2006 18:42:01 -0500
User-Agent: KMail/1.8.1
Cc: mj@ucw.cz, seanlkml@sympatico.ca, sam@vilain.net, peter.read@gmail.com,
       matthias.andree@gmx.de, lkml@dervishd.net, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de
References: <43EB7BBA.nailIFG412CGY@burner> <mj+md-20060213.160108.13290.atrey@ucw.cz> <43F0B32D.nailKUS1E3S8I3@burner>
In-Reply-To: <43F0B32D.nailKUS1E3S8I3@burner>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602131842.02377.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 February 2006 11:26, Joerg Schilling wrote:
> Martin Mares <mj@ucw.cz> wrote:
> > Hello!
> >
> > > If there is no interest to fox well known bugs in Linux, I would need
> > > to warn people from using Linux.
> >
> > Except for mentioning some DMA related problems at the beginning of this
> > monstrous thread, you haven't shown anything which even remotely
> > qualifies as a bug.
>
> If you forget these things, then please forget about this thread.
>
> I mentioned:
>
> -	ide-scsi does not do DMA correctly


ide-scsi is deprecated and will be removed at a later date. Any program 
relying on ide-scsi will have to be rewritten.

> -	SCSI commands are bastardized on ATAPI

identify the problem - provide a test case or two and I'll get off my lazy ass 
and see if I can't figure out what's causing the problem.

> If you like, I can give you many other Linux related bugs but it does
> not make sense unless the two bugs above are fixed.

Only one bug needs fixed. ide-scsi is not going to be in the kernel much 
longer. Although someone might find the time to fix the bugs for those people 
dependant on older kernels.

DRH
