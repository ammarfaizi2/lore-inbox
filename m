Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129845AbQKWJKg>; Thu, 23 Nov 2000 04:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130148AbQKWJK1>; Thu, 23 Nov 2000 04:10:27 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:60932 "EHLO
        wire.cadcamlab.org") by vger.kernel.org with ESMTP
        id <S129845AbQKWJKN>; Thu, 23 Nov 2000 04:10:13 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14876.55272.93109.802261@wire.cadcamlab.org>
Date: Thu, 23 Nov 2000 02:40:08 -0600 (CST)
To: R.E.Wolff@bitwizard.nl (Rogier Wolff)
Cc: Patrick van de Lageweg <patrick@bitwizard.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rogier Wolff <wolff@bitwizard.nl>
Subject: Re: [NEW DRIVER] firestream
In-Reply-To: <20001122234047.N2918@wire.cadcamlab.org>
        <200011230822.JAA05965@cave.bitwizard.nl>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Rogier Wolff <R.E.Wolff@bitwizard.nl>]
> However, if my code assumes that the compiler needs to initialize the
                                       ^^^^^^^^kernel
> variable one way or another, I want to put in the initialization,
> even if that means an "= 0;" which is already the default.

Well, your object file just grew 12 bytes.  Not that it matters very
much, since granularity of mm and most filesystems is at least 1k, but
if you have a lot of such variables (or a large array) it can add up.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
