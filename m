Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290843AbSCLWfm>; Tue, 12 Mar 2002 17:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293556AbSCLWfc>; Tue, 12 Mar 2002 17:35:32 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:14976 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S310170AbSCLWfR>;
	Tue, 12 Mar 2002 17:35:17 -0500
Date: Wed, 13 Mar 2002 09:34:23 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: jhf@rivenstone.net (Joseph Fannin)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] DMI patch for broken Dell laptop
Message-Id: <20020313093423.5e0daba1.sfr@canb.auug.org.au>
In-Reply-To: <20020312200948.GA32040@rivenstone.net>
In-Reply-To: <20020312100225.2415c8c6.sfr@canb.auug.org.au>
	<20020312200948.GA32040@rivenstone.net>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joseph,

On Tue, 12 Mar 2002 15:09:48 -0500 jhf@rivenstone.net (Joseph Fannin) wrote:
>
> On Tue, Mar 12, 2002 at 10:02:25AM +1100, Stephen Rothwell wrote:
> > Hi Marcelo, Linus,
> > 
> > This adds DMI recognition for anohter broken Dell laptop BIOS (BIOS
> > version A12 on the Insiron 2500).
> 
>   I think this problem exists for all i2500 BIOS versions > A06. (I
> have such a machine, and access to the BIOS versions back to A08 if
> there is something specific I can test for -- that APM power status
> worked with revision A06 is just heresay.)

Thanks for the offer.  The way to test this is to install each BIOS version,
boot into Linux (preferably in single user mode :-)) and then cat /proc/apm.
If you get an OOPS with then it probably has this problem.  The send
the BIOS versions to us and we will add them to the black list.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
