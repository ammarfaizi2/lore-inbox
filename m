Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129875AbQLHEow>; Thu, 7 Dec 2000 23:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129745AbQLHEoc>; Thu, 7 Dec 2000 23:44:32 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:38661 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129602AbQLHEoT>; Thu, 7 Dec 2000 23:44:19 -0500
Date: Thu, 7 Dec 2000 22:13:47 -0600
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: NTFS repair tools]
Message-ID: <20001207221347.R6567@cadcamlab.org>
In-Reply-To: <3A30552D.A6BE248C@timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A30552D.A6BE248C@timpanogas.org>; from jmerkey@timpanogas.org on Thu, Dec 07, 2000 at 08:27:41PM -0700
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Jeff Merkey]
> Do folks not know this NTFS driver will trash hard drives?  We need
> to alert folks DO NOT USE WRITE NTFS MODE in those versions we know
> are busted.

Here's an idea: let's make r/w support a separate CONFIG option, and
label it "DANGEROUS".

Oh wait, we already do that.

Perhaps we should warn users to back up their NTFS partitions before
trying this option.  Put that warning in the help text for
CONFIG_NTFS_RW.

Oh wait, we already do that too.

How stupid does one have to be in order to enable an option labeled
"DANGEROUS" for a non-experimental system?

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
