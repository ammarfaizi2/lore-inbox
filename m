Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268286AbRIHJVr>; Sat, 8 Sep 2001 05:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268848AbRIHJVg>; Sat, 8 Sep 2001 05:21:36 -0400
Received: from femail25.sdc1.sfba.home.com ([24.254.60.15]:61605 "EHLO
	femail25.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S268286AbRIHJVU>; Sat, 8 Sep 2001 05:21:20 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: Floydsmith@aol.com, hpa@transmeta.com
Subject: Re: Re1: LOADLIN and 2.4 kernels
Date: Sat, 8 Sep 2001 02:21:05 -0700
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <109.548ddae.28cb3697@aol.com>
In-Reply-To: <109.548ddae.28cb3697@aol.com>
MIME-Version: 1.0
Message-Id: <01090802210500.00424@c779218-a>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 September 2001 01:53 am, Floydsmith@aol.com wrote:
> >Hi everyone,
> >
> >I got a bug report of LOADLIN not working with recent -ac kernels, and
> >thought it might have something to do with my recent A20 changes that
> >were added to -ac.  However, in trying to reproduce this bug, I have
> >been completely unable to boot *any* 2.4 kernel with LOADLIN-1.6,
> > trying this from Win98 DOS mode.
> >
> >Anyone have any insight into this?  I really don't understand how the
> >A20 changes could affect LOADLIN, and it's starting to look to me that
> >there is some other problem going on...
> >
> >        -hpa
>

<snip>

> loads the 2.4.x kernel into a buffer. The kernel then attempts boot
> just the "boot" sector stuff. This again probes for the total amount of
> system ram (64MB). But, because of the much greater size of 2.4.x
> kernels some memory location that himem uses (I think - maybe BIOS

Sounds like something booting to Safe Mode Command Prompt Only would fix, 
as opposed to booting to plain command prompt mode
command prompt mode will load some drivers (such as himem), better not to 
load them when using LOADLIN. Safe Mode Command Prompt Only boots 
straight to the command prompt, very similar to setting init to /bin/sh 
for a completely bare single-user mode.
