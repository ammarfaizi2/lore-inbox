Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291280AbSAaUhD>; Thu, 31 Jan 2002 15:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291282AbSAaUgv>; Thu, 31 Jan 2002 15:36:51 -0500
Received: from smtp3.vol.cz ([195.250.128.83]:6149 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id <S291280AbSAaUgm>;
	Thu, 31 Jan 2002 15:36:42 -0500
Date: Tue, 29 Jan 2002 12:54:08 +0000
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@zip.com.au>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] syscall latency improvement #1
Message-ID: <20020129125408.A47@toy.ucw.cz>
In-Reply-To: <18993.1011984842@warthog.cambridge.redhat.com> <Pine.LNX.4.33.0201251626490.2042-100000@penguin.transmeta.com> <3C51FF0C.D3B1E2F7@zip.com.au>, <3C51FF0C.D3B1E2F7@zip.com.au> <200201281018.g0SAIIE22462@Port.imtp.ilyichevsk.odessa.ua> <3C55282C.7D607CFB@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3C55282C.7D607CFB@zip.com.au>; from akpm@zip.com.au on Mon, Jan 28, 2002 at 02:30:04AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The first patch should be against Documentation/CodingStyle.
> What are we trying to achieve here?  What are the guidelines
> for when-to and when-to-not?  I'd say:
> 
> - If a function has a single call site and is static then it
>   is always correct to inline.

Yep, but gcc should figure this out itself. No point helping it.

								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

