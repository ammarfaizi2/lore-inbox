Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281449AbRKMDCc>; Mon, 12 Nov 2001 22:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281453AbRKMDCM>; Mon, 12 Nov 2001 22:02:12 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:20361 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S281449AbRKMDCH>; Mon, 12 Nov 2001 22:02:07 -0500
Date: Mon, 12 Nov 2001 20:01:19 -0700
Message-Id: <200111130301.fAD31JJ15767@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Changed message for GPLONLY symbols
In-Reply-To: <10444.1005619809@kao2.melbourne.sgi.com>
In-Reply-To: <10444.1005619809@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens writes:
> When insmod detects a non-GPL module with unresolved symbols it
> currently says:
> 
> Note: modules without a GPL compatible license cannot use GPLONLY_ symbols
> 
> I thought that hint was self-explanatory, obviously it was not clear.
> Never underestimate the ability of lusers to misread a message.  insmod
> 2.4.12 will say
> 
> Hint: You are trying to load a module without a GPL compatible license
>       and it has unresolved symbols.  The module may be trying to access
>       GPLONLY symbols but the problem is more likely to be a coding or
>       user error.  Contact the module supplier for assistance.
> 
> Does anyone think that this message can be misunderstood by anybody
> with the "intelligence" of the normal Windoze user?

How about actually checking if the unresolved symbols are available in
the GPLONLY area? That would allow you to be more precise.

[Perhaps this has already been suggested: I haven't been paying
attention]

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
