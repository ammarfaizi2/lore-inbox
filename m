Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315120AbSE2Lnw>; Wed, 29 May 2002 07:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315162AbSE2Lnv>; Wed, 29 May 2002 07:43:51 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:8948 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315120AbSE2Lnt>; Wed, 29 May 2002 07:43:49 -0400
Subject: Re: odd timer bug, similar to VIA 686a symptoms
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Neale Banks <neale@lowendale.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.05.10205291912340.2523-100000@marina.lowendale.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 29 May 2002 13:46:27 +0100
Message-Id: <1022676387.4124.162.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-05-29 at 10:25, Neale Banks wrote:
>> May 28 11:19:54 gull kernel: timer.c: VIA bug check triggered. Value read 65500 [0xffdc], re-read 65485 [0xffcd]
> May 28 11:19:55 gull kernel: timer.c: VIA bug check triggered. Value read 65500 [0xffdc], re-read 65486 [0xffce]
> May 28 11:19:56 gull kernel: timer.c: VIA bug check triggered. Value read 65500 [0xffdc], re-read 65486 [0xffce]
> May 28 11:19:57 gull kernel: timer.c: VIA bug check triggered. Value read 65499 [0xffdb], re-read 65484 [0xffcc]
> May 28 11:19:58 gull kernel: timer.c: VIA bug check triggered. Value read 65497 [0xffd9], re-read 65483 [0xffcb]
> 
> Anyone got any good theories what's going on here, given that this is a
> ~1995 vintage laptop with a Pentium-120 (which I'm assured doesn't have a
> VIA 686a ;-)?

Neptune chipsets at least had latching bugs on timer reads. What chipset
is the laptop ?

