Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317171AbSGRHol>; Thu, 18 Jul 2002 03:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317192AbSGRHol>; Thu, 18 Jul 2002 03:44:41 -0400
Received: from sproxy.gmx.de ([213.165.64.20]:37639 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S317171AbSGRHok>;
	Thu, 18 Jul 2002 03:44:40 -0400
Message-ID: <3D367295.2010109@gmx.at>
Date: Thu, 18 Jul 2002 09:47:33 +0200
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: Ville Herva <vherva@niksula.hut.fi>
CC: "J. Hart" <jhart@atr.co.jp>, linux-kernel@vger.kernel.org
Subject: Re: File Corruption in Kernel 2.4.18
References: <3D362125.3A324489@atr.co.jp> <20020718072155.GB1548@niksula.cs.hut.fi>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Herva wrote:
> I had enormous trouble with a KT133(A or not) based mobo (Abit-KT7(A)-RAID
> in past - it would just corrupt data when transferring big files from the
> additional ide controller (HPT370 in this case). The Via ide controller
> didn't show this behaviour.

I got a Abit-KT7-RAID with a AMD Thunderbird 800 and also have seen lots 
of trouble. Finally I have figured out that reducing the memory bus 
clock to 100MHz (instead of 133MHz) make my system pretty stable (My 
memory modules can take 133MHz! I checked the specs.). Maybe that 
chipset memory tweaks that the linux kernel does are not enough to fix 
all memory problems...

[snip]
> - Ditched the mobo fo good, bought an Abit ST6R, and never had a problem
>   since. You may be lucky just switching the drive to Via ide.

Well, after messing around with the mobo for almost 2 years, it finally 
seems to be stable. But I wish I could have done useful stuff with my 
computer during that time.

[snip]
> I repoduced the problem with wrchk utility I wrote
> (http://iki.fi/v/tmp/wrchk.c) but it seems you can do it with you directory
> tree copying.

I got to check this out!

bye,
Wilfried

