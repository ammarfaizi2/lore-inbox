Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317569AbSFIGuQ>; Sun, 9 Jun 2002 02:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317571AbSFIGuP>; Sun, 9 Jun 2002 02:50:15 -0400
Received: from fachschaft.cup.uni-muenchen.de ([141.84.250.61]:9479 "EHLO
	fachschaft.cup.uni-muenchen.de") by vger.kernel.org with ESMTP
	id <S317569AbSFIGuO>; Sun, 9 Jun 2002 02:50:14 -0400
Message-Id: <200206090644.g596iMX14841@fachschaft.cup.uni-muenchen.de>
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        davem@redhat.com (David S. Miller)
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
Date: Sun, 9 Jun 2002 08:50:04 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200206090633.g596XZI472183@saturn.cs.uml.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> For memory --> device DMA:
>
> 1. write back all cache lines affected by the DMA
> 2. start the DMA
> 3. invalidate the above cache lines

Why the third step ? That data should still
be valid.

	Regards
		Oliver
