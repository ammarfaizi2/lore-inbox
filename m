Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281773AbRKUMTh>; Wed, 21 Nov 2001 07:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281766AbRKUMT1>; Wed, 21 Nov 2001 07:19:27 -0500
Received: from ns.suse.de ([213.95.15.193]:36105 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S281763AbRKUMTN>;
	Wed, 21 Nov 2001 07:19:13 -0500
Date: Wed, 21 Nov 2001 13:19:12 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Athlon /proc/cpuinfo anomaly [minor]
In-Reply-To: <20011121130838.D9978@suse.de>
Message-ID: <Pine.LNX.4.33.0111211316220.4080-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2001, Jens Axboe wrote:

> Strange, I was pretty sure that earlier 2.4.x got it right. Oh well.

*shrug* As we don't do any setting of this string, all I can guess
at is that the new seqfile based /proc/cpuinfo code is stricter
about getting the info from the right CPU than the older code was.

Though I'm not sure why, as the older code just read from the
per-CPU structs anyway.  Most odd.

regards,
Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

