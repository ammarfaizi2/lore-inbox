Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283938AbSABA7U>; Tue, 1 Jan 2002 19:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286465AbSABA7K>; Tue, 1 Jan 2002 19:59:10 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6662 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S283938AbSABA7H>; Tue, 1 Jan 2002 19:59:07 -0500
Message-ID: <3C325823.7010501@zytor.com>
Date: Tue, 01 Jan 2002 16:45:23 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: robert@schwebel.de, Linux Kernel List <linux-kernel@vger.kernel.org>,
        Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
        Jason Sodergren <jason@mugwump.taiga.com>,
        Anders Larsen <anders@alarsen.net>, rkaiser@sysgo.de
Subject: Re: [PATCH][RFC] AMD Elan patch
In-Reply-To: <Pine.LNX.4.33.0201020104140.26007-100000@Appserv.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

> On Tue, 1 Jan 2002, H. Peter Anvin wrote:
> 
> 
>>Do you happen to know if there is an easy and safe way to detect an Elan
>>at runtime? If so, it might make more sense to make this a runtime
>>decision instead.
>>
> 
> Family 4 Model 10 or so my information tells me.
> Unless there are also others with the same name and different cpuid info.
> 


That identifies the CPU core, but not the chipset -- and it's quite 
likely the CPU core will pop up in other uses.

Not trustworthy.

	-hpa



