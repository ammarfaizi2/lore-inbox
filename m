Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132295AbQKKUIg>; Sat, 11 Nov 2000 15:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132324AbQKKUI1>; Sat, 11 Nov 2000 15:08:27 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:35080 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132295AbQKKUIP>; Sat, 11 Nov 2000 15:08:15 -0500
Message-ID: <3A0DA720.990C4927@transmeta.com>
Date: Sat, 11 Nov 2000 12:08:00 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10-pre3 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Max Inux <maxinux@bigfoot.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: bzImage ~ 900K with i386 test11-pre2
In-Reply-To: <Pine.LNX.4.30.0011110323020.10847-100000@shambat>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Max Inux wrote:
> 
> >gzip, actually.  I can verify here "make bzImage" does the expected thing
> >and it looks normal-sized to me.
> 
> I believe there is zImage (gzip) and bzImage (bzip2). (Or is it compress
> vs gzip, but then why bzImage vs gzImage?)
> 

b is "big".  They are both gzip compressed.  zImage has a size limit
which bzImage doesn't.  zImage is pretty much obsolete.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
