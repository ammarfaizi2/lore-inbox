Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266040AbRHNJDJ>; Tue, 14 Aug 2001 05:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267651AbRHNJDA>; Tue, 14 Aug 2001 05:03:00 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:52750 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S266040AbRHNJCn>;
	Tue, 14 Aug 2001 05:02:43 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Nils Faerber <nils@kernelconcepts.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix 2.4.8 compile errors 
In-Reply-To: Your message of "Tue, 14 Aug 2001 10:51:59 +0200."
             <3B78E6AF.449B903B@kernelconcepts.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 14 Aug 2001 19:02:51 +1000
Message-ID: <25616.997779771@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2001 10:51:59 +0200, 
Nils Faerber <nils@kernelconcepts.de> wrote:
>The first hunk seems OK to me but the second one is a little crude.
>There are also other architectures that use the Epson 1355 framebuffer;
>we had for example a MIPS reference design from Toshiba here that had
>that one. Limiting this to just SH architecture goes a little too far.

Not unless you change the code.  drivers/video/epson1355fb.c
#ifdef CONFIG_SUPERH
...
#else
#error unknown architecture
#endif

