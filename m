Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129532AbRAXUyR>; Wed, 24 Jan 2001 15:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129703AbRAXUyI>; Wed, 24 Jan 2001 15:54:08 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:5905 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129532AbRAXUx4>;
	Wed, 24 Jan 2001 15:53:56 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200101242053.f0OKrps154856@saturn.cs.uml.edu>
Subject: Re: vfat <-> vfat copying of ~700MB file, so slow!
To: misiek@pld.ORG.PL (Arkadiusz Miskiewicz)
Date: Wed, 24 Jan 2001 15:53:51 -0500 (EST)
Cc: linux-kernel@vger.kernel.org, chaffee@cs.berkeley.edu
In-Reply-To: <20010124131431.A19957@ikar.t17.ds.pwr.wroc.pl> from "Arkadiusz Miskiewicz" at Jan 24, 2001 01:14:31 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Copying between vfat <-> vfat partitions is so slow. It seems
> that it's vfat/msdos kernel driver problem because I tried to copy

I reported this years ago, with a 700 kB file on a floppy and
a 4 MB file on a Zip disk. In both cases mcopy was several times
faster than the kernel code.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
