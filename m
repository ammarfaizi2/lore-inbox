Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263088AbSJBOQc>; Wed, 2 Oct 2002 10:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263089AbSJBOQc>; Wed, 2 Oct 2002 10:16:32 -0400
Received: from skynet.stack.nl ([131.155.140.225]:41734 "EHLO skynet.stack.nl")
	by vger.kernel.org with ESMTP id <S263088AbSJBOQb>;
	Wed, 2 Oct 2002 10:16:31 -0400
Date: Wed, 2 Oct 2002 16:21:58 +0200 (CEST)
From: Jos Hulzink <josh@stack.nl>
To: Eriksson Stig <stig.eriksson@sweco.se>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: aic7xxx problems?
In-Reply-To: <E50A0EFD91DBD211B9E40008C75B6CCA01497EDD@ES-STH-012>
Message-ID: <20021002161230.C61414-100000@toad.stack.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Oct 2002, Eriksson Stig wrote:

> Hi
>
> The "BNCHMARK DLT1" is actually a hp DLT.
> When rewinding this tape, using "mt -f /dev/nst0 rewind" with a reasonable
> amount of data on the tape (~2 Gigs), i get the following in
> /var/log/messages:
>
> Sep  9 14:01:21 lack kernel: scsi1:0:5:0: Attempting to queue an ABORT
> message
> Sep  9 14:01:21 lack kernel: scsi1: Dumping Card State in Command phase, at
> SEQADDR 0x168

This bug seems almost as old as 2.5. Had errors like this in (iirc) 2.5.9
already. Since I didn't trust any 2.5 anymore (I still see serious PIIX
bugs appearing on this list) I never tried to debug it. Maybe I'll say
a prayer and install .40 tonight.

Jos

