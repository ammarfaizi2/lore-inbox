Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319089AbSHMWij>; Tue, 13 Aug 2002 18:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319090AbSHMWij>; Tue, 13 Aug 2002 18:38:39 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60687 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319089AbSHMWii>; Tue, 13 Aug 2002 18:38:38 -0400
Message-ID: <3D598B3D.8050006@zytor.com>
Date: Tue, 13 Aug 2002 15:42:05 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020703
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch 4/21] fix ARCH_HAS_PREFETCH
References: <Pine.NEB.4.44.0208140020260.1351-100000@mimas.fachschaften.tu-muenchen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> 
> Ah, my misunderstanding:
> "optimize away" didn't mean "completely remove it" but "transform it to
> something semantically equivalent".
> 

The thing is that gcc has a special rule that keeps it from optimizing
it into something with less than O(n) time.

	-=hpa


