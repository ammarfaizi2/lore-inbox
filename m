Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281750AbRKUL4M>; Wed, 21 Nov 2001 06:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281746AbRKUL4C>; Wed, 21 Nov 2001 06:56:02 -0500
Received: from ns.suse.de ([213.95.15.193]:60934 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S281743AbRKULzt>;
	Wed, 21 Nov 2001 06:55:49 -0500
Date: Wed, 21 Nov 2001 12:55:48 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Athlon /proc/cpuinfo anomaly [minor]
In-Reply-To: <20011121124706.C9978@suse.de>
Message-ID: <Pine.LNX.4.33.0111211252500.4080-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2001, Jens Axboe wrote:

> [root@bart x86info-1.5]# ./x86info -a | grep "name string"
> Processor name string: AMD Athlon(tm) MP Processor 1700+
> Processor name string: AMD Athlon(tm) MP Processor 1700+
> [root@bart x86info-1.5]# ./x86info -a | grep "name string"
> Processor name string: AMD Athlon(tm) Processor
> Processor name string: AMD Athlon(tm) Processor

Thanks. Looks like I was right, your BIOS isn't doing
the 'right thing' for CPU 2. Cest la vie.

(The "Sometimes returns different results" bug fixed in CVS,
 release later today btw)

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

