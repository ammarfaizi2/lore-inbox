Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129904AbRBJFNN>; Sat, 10 Feb 2001 00:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129946AbRBJFMy>; Sat, 10 Feb 2001 00:12:54 -0500
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:51461 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S129904AbRBJFMt>; Sat, 10 Feb 2001 00:12:49 -0500
Date: Sat, 10 Feb 2001 18:12:46 +1300
From: Chris Wedgwood <cw@f00f.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bidirectional named pipe?
Message-ID: <20010210181246.C8934@metastasis.f00f.org>
In-Reply-To: <E14OxTz-0007yS-00@the-village.bc.nu> <3A81D5B4.9CBC9B0D@kasey.umkc.edu> <95v90g$ke6$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <95v90g$ke6$1@cesium.transmeta.com>; from hpa@zytor.com on Thu, Feb 08, 2001 at 03:10:08PM -0800
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2001 at 03:10:08PM -0800, H. Peter Anvin wrote:

    I would really like it if open() on a socket would be the same
    thing to connect to a socket as a client.  I don't think it's a
    good idea to do that for the server side, though, since it would
    have to know about accept() anyway.

things like this (non-portable hacks) belong in libc surely?



  --cw
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
