Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284106AbRLANwf>; Sat, 1 Dec 2001 08:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284105AbRLANwZ>; Sat, 1 Dec 2001 08:52:25 -0500
Received: from femail2.sdc1.sfba.home.com ([24.0.95.82]:37314 "EHLO
	femail2.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S284102AbRLANwN>; Sat, 1 Dec 2001 08:52:13 -0500
Message-ID: <3C08DFC1.79C1EC28@didntduck.org>
Date: Sat, 01 Dec 2001 08:48:49 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.5.1-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Niels Kristian Bech Jensen <nkbj@image.dk>
CC: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: keyboard: Timeout - AT keyboard not present?(f4)
In-Reply-To: <Pine.LNX.4.33.0111300728330.1010-100000@hafnium.nkbj.dk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Niels Kristian Bech Jensen wrote:
> 
> Since linux-2.5.1-pre3 (the first 2.5.x kernel I booted) I get one
> or more these warnings in my log:
> 
> keyboard: Timeout - AT keyboard not present?(f4)
> 
> It's on a pentium-mmx system with a PS/2 keyboard. The keyboard works
> OK.
> 
> --
> Niels Kristian Bech Jensen -- nkbj@image.dk -- http://www.image.dk/~nkbj/
> 
> ----------->>  Stop software piracy --- use free software!  <<-----------
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

I'm seeing the same thing.  2.5.1-pre2 does not do this, but 2.5.1-pre5
does.  The message occurs only twice, and appears to be triggered by
starting gpm.  PS/2 mouse on a FIC SD-11 mobo.

-- 

						Brian Gerst
