Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129602AbQLHFSi>; Fri, 8 Dec 2000 00:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131656AbQLHFS3>; Fri, 8 Dec 2000 00:18:29 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:46852 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129602AbQLHFSY>; Fri, 8 Dec 2000 00:18:24 -0500
Message-ID: <3A3066EC.3B657570@timpanogas.org>
Date: Thu, 07 Dec 2000 21:43:24 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Samuelson <peter@cadcamlab.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: NTFS repair tools]
In-Reply-To: <3A30552D.A6BE248C@timpanogas.org> <20001207221347.R6567@cadcamlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Peter Samuelson wrote:
> 
> [Jeff Merkey]
> > Do folks not know this NTFS driver will trash hard drives?  We need
> > to alert folks DO NOT USE WRITE NTFS MODE in those versions we know
> > are busted.
> 
> Here's an idea: let's make r/w support a separate CONFIG option, and
> label it "DANGEROUS".
> 
> Oh wait, we already do that.
> 
> Perhaps we should warn users to back up their NTFS partitions before
> trying this option.  Put that warning in the help text for
> CONFIG_NTFS_RW.
> 
> Oh wait, we already do that too.
> 
> How stupid does one have to be in order to enable an option labeled
> "DANGEROUS" for a non-experimental system?

Agree.  We need to disable it, since folks do not read the docs
(obviously).  Of course, we could leave it on, and I could start
charging money for these tools -- there's little doubt it would be a
lucrative business.  Perhaps this is what I'll do if the numbers of
copies keeps growing.  When it hits > 100 per week, it's taking a lot of
our time to support, so I will have to start charging for it.

Jeff

Jeff   


> 
> Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
