Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287488AbSBMQXZ>; Wed, 13 Feb 2002 11:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287596AbSBMQXQ>; Wed, 13 Feb 2002 11:23:16 -0500
Received: from chaos.analogic.com ([204.178.40.224]:26757 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S287488AbSBMQXA>; Wed, 13 Feb 2002 11:23:00 -0500
Date: Wed, 13 Feb 2002 11:25:09 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ? 
In-Reply-To: <200202131419.g1DEJeUJ001359@tigger.cs.uni-dortmund.de>
Message-ID: <Pine.LNX.3.95.1020213111701.17207A-101000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1678434306-693191476-1013617509=:17207"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1678434306-693191476-1013617509=:17207
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 13 Feb 2002, Horst von Brand wrote:

> Daniel Phillips <phillips@bonn-fries.net> said:
> > On February 12, 2002 05:38 pm, Bill Davidsen wrote:
> 
> [...]
[SNIPPED...]

My idea is to take the .config file and remove most of its
redundancy and unnecessary verbage. Then, the result is
compressed and written to a constant global array, linked
into the kernel. Both the array and the array length will then
be available from /proc/kcore for user-mode tools to recreate the
.config file.

Here are tools and a test/documentation script that shows it
will work. The .config on my machine generates a 1730 byte
array. This is certainly small enough to not be considered
bloat.

The advantage, of course is that if you are executing the kernel,
it can give you all the information necessary to recreate a
new one from the sources because its .config is embeded into
itself. Once you have the ".config" file, you just do `make oldconfig`
and you are home free.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


--1678434306-693191476-1013617509=:17207
Content-Type: APPLICATION/octet-stream; name="config.tar.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.3.95.1020213112509.17207B@chaos.analogic.com>
Content-Description: 

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
--1678434306-693191476-1013617509=:17207--
