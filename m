Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263615AbTDCUiT 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 15:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263616AbTDCUiS 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 15:38:18 -0500
Received: from mail.goshen.edu ([199.8.232.22]:11137 "EHLO mail.goshen.edu")
	by vger.kernel.org with ESMTP id S263615AbTDCUiP 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 15:38:15 -0500
Subject: Re: RAID 5 performance problems
From: Ezra Nugroho <ezran@goshen.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-raid@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0304032104070.3085@ddx.a2000.nu>
References: <Pine.GSO.4.30.0304030858080.20118-100000@multivac.sdsc.edu> 
	<Pine.LNX.4.53.0304032104070.3085@ddx.a2000.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9.7x.1) 
Date: 03 Apr 2003 16:02:32 -0500
Message-Id: <1049403752.22426.5146.camel@ezran.goshen.edu>
Mime-Version: 1.0
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> here benchmark from my system with an fasttrak-tx4 (same card jonathan
> has) with WD1800BB :
> 
> /dev/hde:
>  Timing buffer-cache reads:   128 MB in  0.28 seconds =457.14 MB/sec
>  Timing buffered disk reads:  64 MB in  1.37 seconds = 46.72 MB/sec
> 
> WD1800BB on onboard ultra100 controller :
> 
> /dev/hdo:
>  Timing buffer-cache reads:   128 MB in  0.28 seconds =457.14 MB/sec
>  Timing buffered disk reads:  64 MB in  1.58 seconds = 40.51 MB/sec
> 
> WD1800BB on onboard ultra33 controller :
> 
> /dev/hda:
>  Timing buffer-cache reads:   128 MB in  0.28 seconds =457.14 MB/sec
>  Timing buffered disk reads:  64 MB in  2.55 seconds = 25.10 MB/sec

What should I expect from a 8 drive raid 5 on 3ware 7500-8?
I get only 
/dev/sda:
 Timing buffer-cache reads:   128 MB in  0.74 seconds =172.97 MB/sec
 Timing buffered disk reads:  64 MB in  1.55 seconds = 41.29 MB/sec

which seems to be slow compared to the numbers above
 


