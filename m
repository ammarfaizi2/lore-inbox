Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVARRjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVARRjo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 12:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVARRjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 12:39:44 -0500
Received: from smtp.uninet.ee ([194.204.0.4]:56586 "EHLO smtp.uninet.ee")
	by vger.kernel.org with ESMTP id S261352AbVARRjj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 12:39:39 -0500
Message-ID: <41ED49B3.1060200@tuleriit.ee>
Date: Tue, 18 Jan 2005 19:38:59 +0200
From: Indrek Kruusa <indrek.kruusa@tuleriit.ee>
Reply-To: indrek.kruusa@tuleriit.ee
User-Agent: Mozilla Thunderbird 0.8 (X11/20040923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: [QUESTION - FYI] Vectorized CRC calculation
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
First, sorry about the so-so topic for the kernel developers...but still 
there are such things inside :)
Currently I am investigating how "they" divide those polynomials and 
which possibilities exists to use SIMD for such calculations. I have 
found several papers about how to do it with Altivec and my question is: 
does anybody knows about efforts to use Altivec for CRC calculations 
here? Topic itself is quite old...
Or is there just any other ongoing developments which implements for 
example permute/shuffle instructions (Altivec: vperm/SSE2: pshufd) for 
table lookups?

One more question: is there PCI/PCIe cards (eg. router) which implements 
Layer 3(-4) in hardware and which are possible to use as "hardware net 
accelerator"?

thanks,
Indrek


Links
-------

Most latest updated C code CRC calculation I have found
http://lxr.mozilla.org/seamonkey/source/modules/zlib/src/crc32.c


"TCP/IP checksum vectorization using AltiVec"
http://www.ibm.com/technology/power/newsletter/october2004/files/web.pdf

"Altivec extension to powerpc accelerates media processing" (includes 
hints for table lookup code)
http://ccrc.wustl.edu/~jefritts/CS525_SP03/readings/altivec.pdf

