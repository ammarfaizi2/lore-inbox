Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287488AbSCHQmz>; Fri, 8 Mar 2002 11:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310946AbSCHQmp>; Fri, 8 Mar 2002 11:42:45 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:45994 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S287488AbSCHQmh>; Fri, 8 Mar 2002 11:42:37 -0500
Date: Fri, 8 Mar 2002 09:42:01 -0700
Message-Id: <200203081642.g28Gg1518485@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.6 IDE 18
In-Reply-To: <3C88DCEF.5000708@evision-ventures.com>
In-Reply-To: <Pine.LNX.4.33.0202232152200.26469-100000@home.transmeta.com>
	<3C88DCEF.5000708@evision-ventures.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki writes:
> - Add EXPORT_SYMBOL(ide_fops) again, since it's used in ide-cd.c add
>    a note there that this is actually possibly adding the same
>    device twice to the devfs stuff.

If it is adding the same device twice, that's definately a
bug. Duplicate devfs entries are not allowed.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
