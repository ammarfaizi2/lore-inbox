Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262798AbSI2QVF>; Sun, 29 Sep 2002 12:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262799AbSI2QVF>; Sun, 29 Sep 2002 12:21:05 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:46538 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S262798AbSI2QVE>;
	Sun, 29 Sep 2002 12:21:04 -0400
Date: Sun, 29 Sep 2002 18:26:28 +0200
From: bert hubert <ahu@ds9a.nl>
To: Lorenzo Allegrucci <l.allegrucci@tiscalinet.it>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: qsbench, interesting results
Message-ID: <20020929162627.GA1270@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Lorenzo Allegrucci <l.allegrucci@tiscalinet.it>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <200209291615.24158.l.allegrucci@tiscalinet.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209291615.24158.l.allegrucci@tiscalinet.it>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2002 at 04:15:24PM +0200, Lorenzo Allegrucci wrote:
> 
> qsbench is a VM benchmark based on sorting a large array
> by quick sort.
> http://web.tiscali.it/allegrucci/qsbench-1.0.0.tar.gz
> 
> Below are some results of qsbench sorting a 350Mb array
> on a 256+400Mb RAM+swap machine.
> Tested kernels: 2.4.19, 2.5.38 and 2.5.39
> All runs made with the same default seed, to compare
> apples with apples :)

Check if the seed is really identical. Furthermore, can you check how much
lowmem is actually available according to the dmesg output? It may be that
your graphics adaptor is using ram in one kernel but not in another.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
