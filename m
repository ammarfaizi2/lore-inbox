Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131487AbRBKBjT>; Sat, 10 Feb 2001 20:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131511AbRBKBjK>; Sat, 10 Feb 2001 20:39:10 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:42764 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131487AbRBKBjC>; Sat, 10 Feb 2001 20:39:02 -0500
Message-ID: <3A85ED20.761E8240@transmeta.com>
Date: Sat, 10 Feb 2001 17:38:40 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: bidirectional named pipe?
In-Reply-To: <E14OxTz-0007yS-00@the-village.bc.nu> <3A81D5B4.9CBC9B0D@kasey.umkc.edu> <95v90g$ke6$1@cesium.transmeta.com> <20010210181246.C8934@metastasis.f00f.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> 
> On Thu, Feb 08, 2001 at 03:10:08PM -0800, H. Peter Anvin wrote:
> 
>     I would really like it if open() on a socket would be the same
>     thing to connect to a socket as a client.  I don't think it's a
>     good idea to do that for the server side, though, since it would
>     have to know about accept() anyway.
> 
> things like this (non-portable hacks) belong in libc surely?
> 

Not if it makes more sense to implement in the kernel.  I can't think of
a way to implement it in glibc without races, perhaps you can.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
