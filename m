Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315471AbSEZAJC>; Sat, 25 May 2002 20:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315476AbSEZAJB>; Sat, 25 May 2002 20:09:01 -0400
Received: from jalon.able.es ([212.97.163.2]:56724 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S315471AbSEZAJA>;
	Sat, 25 May 2002 20:09:00 -0400
Date: Sun, 26 May 2002 03:08:49 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
Cc: Luigi Genoni <kernel@Expansa.sns.it>, Dave Jones <davej@suse.de>,
        "J.A. Magallon" <jamagallon@able.es>, Luca Barbieri <ldb@ldb.ods.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.4] [2.5] [i386] Add support for GCC 3.1 -march=pentium{-mmx,3,4}
Message-ID: <20020526010849.GA10643@werewolf.able.es>
In-Reply-To: <Pine.LNX.4.44.0205260044270.10923-100000@sharra.ivimey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.05.26 Ruth Ivimey-Cook wrote:
>On Sun, 26 May 2002, Luigi Genoni wrote:
>>On Sun, 26 May 2002, Dave Jones wrote:
>>> On Sun, May 26, 2002 at 01:37:39AM +0200, J.A. Magallon wrote:
>>>  > Could you also split
>>>  > 	Pentium-Pro/Celeron/Pentium-II     CONFIG_M686
>>>  > into
>>>  > 	Pentium-Pro            CONFIG_M686
>>>  > 	Pentium-II/Celeron     CONFIG_MPENTIUMII
>>> There are also a few extra Athlon targets iirc. athlon-xp and the like,
>>> which I'm not sure the purpose of. Some gcc know-all want to clue me in
>>> to what these offer over -march=athlon ?
>>>
>>I do not know about the gcc options, but Athlon XP/MP has sse instruction,
>>while tbird has not, so it could be relate to this.
>>

Problem is that CPU selection is not based on cpu itself, but in options
offered by previous gcc compilers.

I think that the menu should contain separate config options for each
processor type, so it is easily modifiable for specific optimizations
offered by new compilers (for example, gcc-3.1 splitting i686 in
pentium-pro, p2, p3 and p4), or some braindead hacker can optimize
code snippets for some kind of processor.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.18 #1 SMP sáb may 25 14:44:46 CEST 2002 i686
