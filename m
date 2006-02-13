Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbWBMRW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWBMRW2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 12:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWBMRW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 12:22:28 -0500
Received: from user-0c93tin.cable.mindspring.com ([24.145.246.87]:21900 "EHLO
	tsurukikun.utopios.org") by vger.kernel.org with ESMTP
	id S932318AbWBMRW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 12:22:27 -0500
From: Luke-Jr <luke@dashjr.org>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Mon, 13 Feb 2006 17:22:27 +0000
User-Agent: KMail/1.9
Cc: mj@ucw.cz, seanlkml@sympatico.ca, sam@vilain.net, peter.read@gmail.com,
       matthias.andree@gmx.de, lkml@dervishd.net, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de
References: <43EB7BBA.nailIFG412CGY@burner> <mj+md-20060213.160108.13290.atrey@ucw.cz> <43F0B32D.nailKUS1E3S8I3@burner>
In-Reply-To: <43F0B32D.nailKUS1E3S8I3@burner>
Public-GPG-Key: 0xD53E9583
Public-GPG-Key-URI: http://dashjr.org/~luke-jr/myself/Luke-Jr.pgp
IM-Address: luke-jr@jabber.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602131722.29633.luke@dashjr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 February 2006 16:26, Joerg Schilling wrote:
> Martin Mares <mj@ucw.cz> wrote:
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

IIRC, ide-scsi is deprecated and would be removed as a fix for this bug. Note 
that ide-scsi is known to be broken in more ways than just this-- for 
example, unloading the module causes a kernel panic.

> -	SCSI commands are bastardized on ATAPI

I'm not a kernel developer, but my understanding is that they're basically 
passed through the ATAPI layer.
