Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316342AbSEZUCm>; Sun, 26 May 2002 16:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316343AbSEZUCl>; Sun, 26 May 2002 16:02:41 -0400
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:28038 "EHLO
	hawk.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S316342AbSEZUCl>; Sun, 26 May 2002 16:02:41 -0400
Date: Sun, 26 May 2002 16:02:17 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.4] [2.5] [i386] Add support for GCC 3.1
Message-ID: <20020526160217.A1343@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another processor config could be CONFIG_K62.
gcc-3.1 -march=k6-2 benchmarks a little better 
than -march=k6.  Adding CONFIG_XF86_USE_3DNOW=y 
seems to help a little too.

Based on grepping gcc-3.1 src, it appears:
k6-3 == k6-2
athlon-tbird == athlon
athlon-xp == athlon-4 == athlon-mp

-- 
Randy Hron

