Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129415AbQLFV1H>; Wed, 6 Dec 2000 16:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129392AbQLFV0r>; Wed, 6 Dec 2000 16:26:47 -0500
Received: from [212.32.186.211] ([212.32.186.211]:39596 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S129267AbQLFV0h>; Wed, 6 Dec 2000 16:26:37 -0500
Date: Wed, 6 Dec 2000 21:55:58 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: "Igor Yu. Zhbanov" <bsg@uniyar.ac.ru>
cc: linux-kernel@vger.kernel.org, Alan.Cox@linux.org
Subject: Re: [PATCH] Bug in date converting functions DOS<=>UNIX in FAT,
 NCPFS and SMBFS drivers [second attempt]
In-Reply-To: <Pine.GSO.3.96.SK.1001205191049.27946A-200000@univ.uniyar.ac.ru>
Message-ID: <Pine.LNX.4.21.0012060029270.6240-100000@cola.svenskatest.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2000, Igor Yu. Zhbanov wrote:

> Hello!

Hello again

> As I see now in 2.2.18pre24 NCPFS is fixed but VFAT and SMBFS doesn't. (This
> happened because the maintainer of NCPFS resent my patch to Alan Cox but only the
> part of patch related to NCPFS). So I resent you patch for VFAT and SMBFS attached
> to this letter.

Yes. Did you get my letter with questions on day-1?

I'll repeat: As I see it you can end up one day before 1980-01-01 if the
input is all 0 since days are also numbered from 1. Does that need to be
fixed too or is it not a problem?

/Urban

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
