Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286317AbRLTSaJ>; Thu, 20 Dec 2001 13:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286318AbRLTSaA>; Thu, 20 Dec 2001 13:30:00 -0500
Received: from ns.suse.de ([213.95.15.193]:19978 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S286317AbRLTS3o>;
	Thu, 20 Dec 2001 13:29:44 -0500
Date: Thu, 20 Dec 2001 19:29:43 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: William Lee Irwin III <wli@holomorphy.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Poor performance during disk writes
In-Reply-To: <3C222BB5.B2CCC11B@zip.com.au>
Message-ID: <Pine.LNX.4.33.0112201927440.2519-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Dec 2001, Andrew Morton wrote:

> You need to run
> 	elvtune -b N /dev/hdXX
> where N=0 is "disable", N=1 is minimum read latency, N=6 is
> a reasonable setting.

I'm curious, why was max_bomb_segments dropped the last time
it was in the tree ? I recall it happening, but the reason
escapes me.

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

