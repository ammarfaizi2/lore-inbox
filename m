Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbQKHD0g>; Tue, 7 Nov 2000 22:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129363AbQKHD00>; Tue, 7 Nov 2000 22:26:26 -0500
Received: from praseodumium.btinternet.com ([194.73.73.82]:25287 "EHLO
	praseodumium.btinternet.com") by vger.kernel.org with ESMTP
	id <S129057AbQKHD0K>; Tue, 7 Nov 2000 22:26:10 -0500
From: davej@suse.de
Date: Wed, 8 Nov 2000 03:25:56 +0000 (GMT)
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Installing kernel 2.4
In-Reply-To: <3A089254.397115FE@timpanogas.org>
Message-ID: <Pine.LNX.4.21.0011080322350.8632-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2000, Jeff V. Merkey wrote:

> If the compiler always aligned all functions and data on 16 byte
> boundries (NetWare)  for all i386 code, it would run a lot faster.

Except on architectures where 16 byte alignment isn't optimal.

> Cache line alignment could be an option in the loader .... after all,
> it's hte loader that locates data in memory.  If Linux were PE based,
> relocation logic would be a snap with this model (like NT).

Are you suggesting multiple files of differing alignments packed into
a single kernel image, and have the loader select the correct one at
runtime ? I really hope I've misinterpreted your intention.

regards,

Davej.

-- 
| Dave Jones <davej@suse.de>  http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
