Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131176AbQKIVD5>; Thu, 9 Nov 2000 16:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131342AbQKIVDs>; Thu, 9 Nov 2000 16:03:48 -0500
Received: from enterprise.cistron.net ([195.64.68.33]:25607 "EHLO
	enterprise.cistron.net") by vger.kernel.org with ESMTP
	id <S131176AbQKIVDb>; Thu, 9 Nov 2000 16:03:31 -0500
From: miquels@cistron.nl (Miquel van Smoorenburg)
Subject: Re: Used space in bytes
Date: 9 Nov 2000 21:03:30 GMT
Organization: Cistron Internet Services B.V.
Message-ID: <8uf3f2$41d$1@enterprise.cistron.net>
In-Reply-To: <20001109191843.B11373@atrey.karlin.mff.cuni.cz> <8uf21i$ro7$1@cesium.transmeta.com>
X-Trace: enterprise.cistron.net 973803810 4141 195.64.65.201 (9 Nov 2000 21:03:30 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <8uf21i$ro7$1@cesium.transmeta.com>,
H. Peter Anvin <hpa@zytor.com> wrote:
>Report a block size (really allocation unit size) st_blocks == 1?

If you mean st_blksize, well:

       The value st_blocks gives the size of the file in 512-byte
       blocks.  The value st_blksize gives the "preferred" block­
       size for efficient file system I/O.  (Writing to a file in
       smaller  chunks  may  cause  an  inefficient  read-modify-
       rewrite.)

Telling programs 'please use 1-byte r/w buffers' is probably
a bad idea.

Mike.
-- 
People get the operating system they deserve.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
