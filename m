Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129388AbQKKL2p>; Sat, 11 Nov 2000 06:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129608AbQKKL2f>; Sat, 11 Nov 2000 06:28:35 -0500
Received: from app79.hitnet.RWTH-Aachen.DE ([137.226.181.79]:35595 "EHLO
	anduin.gondor.com") by vger.kernel.org with ESMTP
	id <S129388AbQKKL21>; Sat, 11 Nov 2000 06:28:27 -0500
Date: Sat, 11 Nov 2000 12:28:24 +0100
From: Jan Niehusmann <jan@gondor.com>
To: Max Inux <maxinux@bigfoot.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: bzImage ~ 900K with i386 test11-pre2
Message-ID: <20001111122823.A1529@gondor.com>
In-Reply-To: <3A0CB6FD.D4CCE09F@transmeta.com> <Pine.LNX.4.30.0011110323020.10847-100000@shambat>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0011110323020.10847-100000@shambat>; from maxinux@bigfoot.com on Sat, Nov 11, 2000 at 03:27:36AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2000 at 03:27:36AM -0800, Max Inux wrote:
> >gzip, actually.  I can verify here "make bzImage" does the expected thing
> >and it looks normal-sized to me.
> 
> I believe there is zImage (gzip) and bzImage (bzip2). (Or is it compress
> vs gzip, but then why bzImage vs gzImage?)

IMHO bzImage means something like 'big zImage', it uses the same compression
but a different loader. IIRC bzImage became necessary when the (uncompressed)
kernel grew above 1MB. 

Jan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
