Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287145AbSABWyo>; Wed, 2 Jan 2002 17:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287143AbSABWyf>; Wed, 2 Jan 2002 17:54:35 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3594 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287144AbSABWy1>; Wed, 2 Jan 2002 17:54:27 -0500
Message-ID: <3C338C57.2080902@zytor.com>
Date: Wed, 02 Jan 2002 14:40:23 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Dave Jones <davej@suse.de>, Robert Schwebel <robert@schwebel.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
        Jason Sodergren <jason@mugwump.taiga.com>,
        Anders Larsen <anders@alarsen.net>, rkaiser@sysgo.de
Subject: Re: [PATCH][RFC] AMD Elan patch
In-Reply-To: <E16LnyN-0004aG-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>x86info is the closest thing to a complete list, but as hpa pointed out,
>>the problem identifying the cpu is easy, identifying the chipset is the
>>hard part.
>>
> 
> I can guarantee 100% correct chipset identification. If you meet an ELAN410
> it is the chipset too. The ISA and VLB come directly off the CPU
> 

That's not the problem, really... the problems is that CPUID identifies 
the CPU core, and embedded CPU cores tend to be used and reused many 
times -- in fact, AMD are quite good at that.

	-hpa

