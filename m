Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281761AbRKUMJP>; Wed, 21 Nov 2001 07:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281760AbRKUMJG>; Wed, 21 Nov 2001 07:09:06 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:62482 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S281758AbRKUMI4>;
	Wed, 21 Nov 2001 07:08:56 -0500
Date: Wed, 21 Nov 2001 13:08:38 +0100
From: Jens Axboe <axboe@suse.de>
To: Dave Jones <davej@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Athlon /proc/cpuinfo anomaly [minor]
Message-ID: <20011121130838.D9978@suse.de>
In-Reply-To: <20011121124706.C9978@suse.de> <Pine.LNX.4.33.0111211252500.4080-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111211252500.4080-100000@Appserv.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21 2001, Dave Jones wrote:
> On Wed, 21 Nov 2001, Jens Axboe wrote:
> 
> > [root@bart x86info-1.5]# ./x86info -a | grep "name string"
> > Processor name string: AMD Athlon(tm) MP Processor 1700+
> > Processor name string: AMD Athlon(tm) MP Processor 1700+
> > [root@bart x86info-1.5]# ./x86info -a | grep "name string"
> > Processor name string: AMD Athlon(tm) Processor
> > Processor name string: AMD Athlon(tm) Processor
> 
> Thanks. Looks like I was right, your BIOS isn't doing
> the 'right thing' for CPU 2. Cest la vie.

Strange, I was pretty sure that earlier 2.4.x got it right. Oh well.

-- 
Jens Axboe

