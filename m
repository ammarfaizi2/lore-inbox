Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132173AbRAGNt7>; Sun, 7 Jan 2001 08:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132241AbRAGNtu>; Sun, 7 Jan 2001 08:49:50 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:3338 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S132173AbRAGNth>;
	Sun, 7 Jan 2001 08:49:37 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Sourav Sen <sourav@csa.iisc.ernet.in>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Kdb for modules 
In-Reply-To: Your message of "Sun, 07 Jan 2001 19:01:06 +0530."
             <Pine.SOL.3.96.1010107184944.24088A-100000@kohinoor.csa.iisc.ernet.in> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Jan 2001 00:49:30 +1100
Message-ID: <610.978875370@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jan 2001 19:01:06 +0530 (IST), 
Sourav Sen <sourav@csa.iisc.ernet.in> wrote:
>	For using kdb I have done the following:

kdb is not part of the standard linux kernel, linux-kernel is the wrong
mailing list.

>	2) patched the source using kdb-v0.6-2.2.13 as I am using
>	   linux-2.2.16.(I don't know, this kdb for 2.2.13 works for
>	   linux-2.2.16, I haven't used it extensively, so don't know 
>	   whether it works correctly or not?, but I couldn't find kdb
>	   for 2.2.16 in SGI site, any clues in this is very much 
>	   welcomed  :))

kdb v0.6 is out of date and no longer supported.  kdb v1.5 against
2.2.18 is in ftp://oss.sgi.com/projects/kdb/download/ix86/, it supports
modules correctly.  This patch is only there as a courtesy, SGI do not
support kdb on 2.2 kernels, all our debugging work is on 2.4 kernels.
If you want to use kdb on 2.2 kernels, you are pretty much on your own.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
