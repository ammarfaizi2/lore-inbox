Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281552AbRKZKKb>; Mon, 26 Nov 2001 05:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281555AbRKZKKW>; Mon, 26 Nov 2001 05:10:22 -0500
Received: from gnu.in-berlin.de ([192.109.42.4]:17157 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S281552AbRKZKKL>;
	Mon, 26 Nov 2001 05:10:11 -0500
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: bttv module intialization takes much time on kernel-2.4.x
Date: 23 Nov 2001 17:28:46 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrn9vt1qe.8en.kraxel@bytesex.org>
In-Reply-To: <200111231654.fANGs0705731@rai.sytes.net>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 1006536526 8664 127.0.0.1 (23 Nov 2001 17:28:46 GMT)
User-Agent: slrn/0.9.7.1 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tetsuji Rai wrote:
>  Title says it all.  I use bttv module.   When invoking "modprobe bttv" it 
>  takes several minutes to initialize.  When I used kernel-2.2.x it was very 
>  quick, but with kernel-2.4.x it takes a while.   But after that, it works 
>  fine.
>     I don't know why.  Any solutions??

RTFM?

Documentation/video4linux/bttv/README says:

If bttv takes very long to load (happens sometimes with the cheap
cards which have no tuner), try adding this to your modules.conf:
        options i2c-algo-bit bit_test=1

HTH,

  Gerd

