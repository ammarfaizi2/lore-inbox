Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281048AbRKTQVQ>; Tue, 20 Nov 2001 11:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281017AbRKTQVG>; Tue, 20 Nov 2001 11:21:06 -0500
Received: from chaos.analogic.com ([204.178.40.224]:12675 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S281048AbRKTQU7>; Tue, 20 Nov 2001 11:20:59 -0500
Date: Tue, 20 Nov 2001 11:20:53 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Wolfgang Rohdewald <wr6@uni.de>
cc: "J.A. Magallon" <jamagallon@able.es>, James A Sutherland <jas88@cam.ac.uk>,
        Remco Post <r.post@sara.nl>, linux-kernel@vger.kernel.org
Subject: Re: Swap
In-Reply-To: <20011120160131.87644332@localhost.localdomain>
Message-ID: <Pine.LNX.3.95.1011120111730.7650A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2001, Wolfgang Rohdewald wrote:

> On Tuesday 20 November 2001 15:51, J.A. Magallon wrote:
> > When a page is deleted for one executable (because we can re-read it from
> > on-disk binary), it is discarded, not paged out.
> 
> What happens if the on-disk binary has changed since loading the program?
> -

It can't. That's the reason for `install` and other methods of changing
execututable files (mv exe-file exe-file.old ; cp newfile exe-file).
The currently open, and possibly mapped file can be re-named, but it
can't be overwritten.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


