Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310654AbSDMV3U>; Sat, 13 Apr 2002 17:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310666AbSDMV3T>; Sat, 13 Apr 2002 17:29:19 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:16773
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S310654AbSDMV3T>; Sat, 13 Apr 2002 17:29:19 -0400
Date: Sat, 13 Apr 2002 14:27:57 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sverker Wiberg <Sverker.Wiberg@uab.ericsson.se>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Multiple zlib.c's in 2.4.18
Message-ID: <20020413212757.GF10015@opus.bloom.county>
In-Reply-To: <3CB6F332.18225BA4@uab.ericsson.se> <E16wSTJ-0000qU-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2002 at 07:42:01PM +0100, Alan Cox wrote:
> > Further checking reveals that ./arch/ppc/boot/lib/zlib.c is based on
> > zlib-0.95, while the other two are zlib-1.0.4.
> > 
> > Which one should I use? Shouldn't they be merged? And what about the
> > double-free() bug?
> 
> There is progress going on to merge them (see 2.4.19-ac) so hopefully RSN
> that question won't be worth asking. 

All of them that can be anyhow.  I'm hoping no one will touch
arch/ppc/boot/lib/zlib.c :)

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
