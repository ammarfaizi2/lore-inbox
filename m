Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281177AbRKTROR>; Tue, 20 Nov 2001 12:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281170AbRKTROH>; Tue, 20 Nov 2001 12:14:07 -0500
Received: from [194.65.152.209] ([194.65.152.209]:12421 "EHLO
	criticalsoftware.com") by vger.kernel.org with ESMTP
	id <S281171AbRKTROC>; Tue, 20 Nov 2001 12:14:02 -0500
Message-Id: <200111201714.fAKHEc276467@criticalsoftware.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: =?iso-8859-1?q?Lu=EDs=20Henriques?= 
	<lhenriques@criticalsoftware.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: copy to suer space
Date: Tue, 20 Nov 2001 17:08:52 +0000
X-Mailer: KMail [version 1.3.1]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <5.1.0.14.2.20011120165440.00a745b0@pop.cus.cam.ac.uk>
In-Reply-To: <5.1.0.14.2.20011120165440.00a745b0@pop.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't think what you are trying to do is possible. Even if you somehow
> managed to write over the code segment of a user space process (which I
> very much doubt would be possible as I assume the memory is mapped
> read-only)

Is there a way to solve this problem? To temporarly turn it read/write?

>, as soon as the kernel pages out (i.e. discards!) some portion
> of the executable due to memory shortage your changes would be lost, since
> the paging back into memory would happen by reading the executable back
> from disk, which would mean it would read the unmodified code into
> memory...

When I'm modifing the code, I'm sure that the page is in memory because my 
code is called from the user space, in the exact location where I want to 
change it (with a breakpoint interruption...)

The point is that I can't write to the memory location I want... How do I 
solve this?

-- 
Luís Henriques
