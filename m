Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316262AbSEVROJ>; Wed, 22 May 2002 13:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316264AbSEVROI>; Wed, 22 May 2002 13:14:08 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:6792 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S316262AbSEVROH>; Wed, 22 May 2002 13:14:07 -0400
Date: Wed, 22 May 2002 10:13:29 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 IDE 67
Message-ID: <20020522171329.GG1209@opus.bloom.county>
In-Reply-To: <3CEB466B.3090604@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 09:19:07AM +0200, Martin Dalecki wrote:

> Wed May 22 01:43:54 CEST 2002 ide-clean-67
> 
> - Nuke COMMERIAL and similar spurious configuration options...
>   The fact that every single default configuration option contained
>   those bits makes this trivial patch appear rather big.

This also nukes CONFIG_DMA_NONPCI.  While this probably shouldn't have
been define_bool'ed to 'n' all of the time, there are cases where this
seems to be properly used.  I know PPC4xx uses it (or will be using it
once the driver is ready to be submitted) and it looks like cris uses it
as well.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
