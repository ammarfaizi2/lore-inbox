Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAPIl1>; Tue, 16 Jan 2001 03:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129523AbRAPIlQ>; Tue, 16 Jan 2001 03:41:16 -0500
Received: from fungus.teststation.com ([212.32.186.211]:41202 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S129431AbRAPIlE>; Tue, 16 Jan 2001 03:41:04 -0500
Date: Tue, 16 Jan 2001 09:40:47 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: Rainer Mager <rmager@vgkk.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Oops with 4GB memory setting in 2.4.0 stable
In-Reply-To: <NEBBJBCAFMMNIHGDLFKGCENGCMAA.rmager@vgkk.com>
Message-ID: <Pine.LNX.4.30.0101160927130.10663-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jan 2001, Rainer Mager wrote:

> Hi all,
>
> 	I have a 100% reproducable bug in all of the 2.4.0 kernels including the
> latest stable one. The issue is that if I compile the kernel to support 4GB
> RAM (I have 1 GB) and then try to access a samba mount I get an oops. This

I'll have a look tonight or so. It works for you on non-bigmem?

> ALWAYS happens. Usually after this the system is frozen (although the magic
> SYSREQ still works). If the system isn't frozen then any commands that
> access the disk will freeze. Fortunately GPM worked and I was able to paste
> the oops to a file via telnet.

smb_rename suggests mv, but the process is ls ... er? What commands where
you running on smbfs when it crashed?

Could this be a symbol mismatch? Keith Owens suggested a less manual way
to get module symbol output. Do you get the same results using that?

/Urban

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
