Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315942AbSEOMfH>; Wed, 15 May 2002 08:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316053AbSEOMfG>; Wed, 15 May 2002 08:35:06 -0400
Received: from ep09.kernel.pl ([212.87.11.162]:8852 "EHLO ep09.kernel.pl")
	by vger.kernel.org with ESMTP id <S315942AbSEOMfF>;
	Wed, 15 May 2002 08:35:05 -0400
Date: Wed, 15 May 2002 14:34:56 +0200 (CEST)
From: Witek Krecicki <adasi@kernel.pl>
To: Shashidhar MC <shashimc2002@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: all of a sudden !
In-Reply-To: <20020515123144.66286.qmail@web21507.mail.yahoo.com>
Message-ID: <Pine.LNX.4.44.0205151433450.1979-100000@ep09.kernel.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 May 2002, Shashidhar MC wrote:
> Hello,
> 
> I recently installed Red Hat 7.1 (2.4.2-2) on a
> machine with 2GB HD, 32MB RAM.  It works fine, but
> occassionally it throws the following error and it
> hangs:
> <error>
<cut>
> Call Trace: .....
> Code: 8b 04 ...........
> Kernel Panic: Aiee, killing interrupt handler!
> In interrupt handler - not syncing
> 
> </error>
>   I have typed out the error manually on a
> neighbouring machine (because my machine hung) and
> hence replaced those numbers with dots.
> 
> I was just reading a file in a text editor when this
> last happened.
> 
> Any idea why this happens ?  Any solution ?
Try to rewrite it completly (yes, it's possible) then on this hanging 
machine try to do ksymoops < file_with_oops and then send here decoded 
oops
WK

