Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316986AbSEWTKx>; Thu, 23 May 2002 15:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316988AbSEWTKw>; Thu, 23 May 2002 15:10:52 -0400
Received: from [195.63.194.11] ([195.63.194.11]:28943 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316986AbSEWTKv>; Thu, 23 May 2002 15:10:51 -0400
Message-ID: <3CED2FE0.2050903@evision-ventures.com>
Date: Thu, 23 May 2002 20:07:28 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: "Gryaznova E." <grev@namesys.botik.ru>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
        Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: IDE problem: linux-2.5.17
In-Reply-To: <3CECF59B.D471F505@namesys.botik.ru> <3CECFA15.8040707@evision-ventures.com> <3CED2B73.ABA3C95F@namesys.botik.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Gryaznova E. napisa?:
> I have 40 wires cable. When ide=nodma is passed to 2.5.17 kernel - kernel boots.
> Am I correct that it is not possible to have DMA on with such cable?
> Is there any reason for doing that?
> 
> Note that bus speed is 33 MHz when kernel fails to boot.
 > I mean - how do I specify slower bus speed: 22 MHz?

You know what? I don't answer you directly I will just put a note
about this in to Documentation/ide.txt which is long overdue anyway :-).
You should better don't do UDMA>>66 with 40 write cablings. That's all.


