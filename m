Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317036AbSEWWnJ>; Thu, 23 May 2002 18:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317037AbSEWWnI>; Thu, 23 May 2002 18:43:08 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:42146 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317036AbSEWWnE>;
	Thu, 23 May 2002 18:43:04 -0400
Date: Fri, 24 May 2002 00:42:58 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: "Gryaznova E." <grev@namesys.botik.ru>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: IDE problem: linux-2.5.17
Message-ID: <20020524004258.D27005@ucw.cz>
In-Reply-To: <3CECF59B.D471F505@namesys.botik.ru> <3CECFA15.8040707@evision-ventures.com> <3CED2B73.ABA3C95F@namesys.botik.ru> <3CED2FE0.2050903@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2002 at 08:07:28PM +0200, Martin Dalecki wrote:

> > I have 40 wires cable. When ide=nodma is passed to 2.5.17 kernel - kernel boots.
> > Am I correct that it is not possible to have DMA on with such cable?
> > Is there any reason for doing that?
> > 
> > Note that bus speed is 33 MHz when kernel fails to boot.
>  > I mean - how do I specify slower bus speed: 22 MHz?
> 
> You know what? I don't answer you directly I will just put a note
> about this in to Documentation/ide.txt which is long overdue anyway :-).
> You should better don't do UDMA>>66 with 40 write cablings. That's all.

The kernel shouldn't select that automatically. If it does, it's a bug.

As for manual setting, it should emit a warning.

-- 
Vojtech Pavlik
SuSE Labs
