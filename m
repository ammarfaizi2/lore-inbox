Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289933AbSAKM1S>; Fri, 11 Jan 2002 07:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289934AbSAKM0y>; Fri, 11 Jan 2002 07:26:54 -0500
Received: from ns.suse.de ([213.95.15.193]:12302 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289932AbSAKM0a>;
	Fri, 11 Jan 2002 07:26:30 -0500
Date: Fri, 11 Jan 2002 13:26:29 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Anders Vedmar <anders.vedmar@interactiveinstitute.se>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17 raid5 checksumming function selection wierdness
In-Reply-To: <200201111208.g0BC8wI29387@nav.interactiveinstitute.se>
Message-ID: <Pine.LNX.4.33.0201111325090.15636-100000@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2002, Anders Vedmar wrote:

> The raid5 code in 2.4.17 seems to select the slowest available
> checksumming function.
>    8regs     :  2148.000 MB/sec
>    pIII_sse  :  1272.000 MB/sec
> raid5: using function: pIII_sse (1272.000 MB/sec)

SSE is favoured due to it avoiding trashing the cache contents.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

