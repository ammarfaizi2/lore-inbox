Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280944AbRKCLpH>; Sat, 3 Nov 2001 06:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280945AbRKCLor>; Sat, 3 Nov 2001 06:44:47 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:31692 "EHLO
	mailout01.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S280944AbRKCLof>; Sat, 3 Nov 2001 06:44:35 -0500
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] 2.5 PROPOSAL: Replacement for current /proc of shit.
Date: Sat, 3 Nov 2001 12:47:08 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <E15zF9H-0000NL-00@wagner> <15zeoa-0RBdnkC@fmrl04.sul.t-online.com> <20011103103106.7eb6098b.rusty@rustcorp.com.au>
In-Reply-To: <20011103103106.7eb6098b.rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <15zzDZ-0yyjQWC@fmrl02.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 November 2001 00:31, you wrote:
> Hmm, I'd argue that a GUI tool would be fairly useless without knowing what
> the values meant anwyay, to give help, in which case you might as well know
> the types.

Take, as an example, the compression module parameter of the PWC (Philips 
Webcam) driver. Currently you can specify a value between 0 for uncompressed 
and 3 for high compression. If a GUI shows me that only values between 0 and 
3 are allowed I could guess that I have to enter "3" for high compression 
without searching for the documentation. It would be even better if I could 
select four strings, "none", "low", "medium" and "high". 

I do see the advantages of using strings in proc, and maybe there is another 
solution: keep the type information out of the proc filesystem and save it 
in a file similar to Configure.help, together with a description for a file. 
I just don't know how to ensure that they are in sync. 

bye...
