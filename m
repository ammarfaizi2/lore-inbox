Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316672AbSEVSsj>; Wed, 22 May 2002 14:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316675AbSEVSsi>; Wed, 22 May 2002 14:48:38 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:17544
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S316672AbSEVSsh>; Wed, 22 May 2002 14:48:37 -0400
Date: Wed, 22 May 2002 11:47:22 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 IDE 67
Message-ID: <20020522184722.GB5575@opus.bloom.county>
In-Reply-To: <3CEB466B.3090604@evision-ventures.com> <20020522171329.GG1209@opus.bloom.county> <3CEBC576.4060703@evision-ventures.com> <20020522173137.GH1209@opus.bloom.county> <3CEBC9EE.2090701@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 06:40:14PM +0200, Martin Dalecki wrote:
> Uz.ytkownik Tom Rini napisa?:
> >
> >And when the PPC4xx drivers are ready to be submitted we'll need to add
> >in __powerpc__ tests too.  Can't we just keep CONFIG_DMA_NONPCI for now?
> 
> Plese feel free to add them when and where they are needed.
> It's no problem to clean this all up
> then again if a true usage pattern emerges.
> And I have no problem with patches toching "core" driver stuff as long
> as the changes are justified I will integrate them with pleasure at time.

Okay. :)

BTW, maybe it's part of the great IDE rewrite and all, but the
CONFIG_DMA_NONPCI part of drivers/ide/ide.c didn't get a __CRIS__ added
back in.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
