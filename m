Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287860AbSBKLF1>; Mon, 11 Feb 2002 06:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287896AbSBKLFR>; Mon, 11 Feb 2002 06:05:17 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:15627 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S287860AbSBKLFE>; Mon, 11 Feb 2002 06:05:04 -0500
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: bttv driver broken in 2.5.4-pre
Date: 11 Feb 2002 10:32:07 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrna6f7d7.4tb.kraxel@bytesex.org>
In-Reply-To: <3C6725A6.9E9AEC14@delusion.de>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 1013423527 5036 127.0.0.1 (11 Feb 2002 10:32:07 GMT)
User-Agent: slrn/0.9.7.1 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Udo A. Steinberg wrote:
>  
>  Hi Gerd,
>  
>  The latest changes in the 2.5.4 prepatches throw linker errors which seem to be caused by
>  bttv-driver.c using obsolete functions:

I'm not going to fix bttv 0.7.x (that's the version which is in both
2.4.x and 2.5.x).  The redesigned bttv 0.8.x versions work (they never
used virt_to_bus).  You can fetch them from http://bytesex.org/bttv/

bttv 0.8.x depends on some other patches, thus it probably needs some
time before it will show up in 2.5.x.  Expect bttv being broken for a
few releases in 2.5.x kernels.

  Gerd

-- 
#define	ENOCLUE 125 /* userland programmer induced race condition */
