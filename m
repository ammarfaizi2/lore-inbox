Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313014AbSDGJPI>; Sun, 7 Apr 2002 05:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313016AbSDGJPH>; Sun, 7 Apr 2002 05:15:07 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:57867 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S313014AbSDGJPG>; Sun, 7 Apr 2002 05:15:06 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: bttv compile failure in 2.5.8-pre2
Date: 7 Apr 2002 07:44:36 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrnaavu74.t38.kraxel@bytesex.org>
In-Reply-To: <200204062356.g36Nujh03555@vindaloo.ras.ucalgary.ca>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 1018165476 29801 127.0.0.1 (7 Apr 2002 07:44:36 GMT)
User-Agent: slrn/0.9.7.1 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
>    Hi, all. Compiling 2.5.8-pre2, I got the following:
>  
>  bttv-driver.c:2650: `video_generic_ioctl' undeclared here (not in a function)

The same is true for nearly all other v4l drivers.  Dave picked up my
videodev patch from the list and feeded it to Linus, but all the related
driver fixes are not in the kernel yet ...

2.4.7 patches are at http://bytesex.org/patches/2.5/
I'll rediff against -pre2 and resend stuff next days ...

  Gerd

-- 
#include </dev/tty>
