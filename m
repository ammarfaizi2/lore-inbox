Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315503AbSENIxn>; Tue, 14 May 2002 04:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315514AbSENIxm>; Tue, 14 May 2002 04:53:42 -0400
Received: from [195.137.26.28] ([195.137.26.28]:50128 "EHLO
	shami.gointernet.co.uk") by vger.kernel.org with ESMTP
	id <S315503AbSENIxl>; Tue, 14 May 2002 04:53:41 -0400
Message-ID: <3CE0CDC8.1080000@gointernet.co.uk>
Date: Tue, 14 May 2002 09:41:44 +0100
From: Eugenio Mastroviti <eugeniom@gointernet.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Oleg Drokin <green@namesys.com>
CC: "John O'Donnell" <johnnyo@mindspring.com>, linux-kernel@vger.kernel.org
Subject: Re: Reiserfs has killed my root FS!?!
In-Reply-To: <Pine.LNX.4.44.0205121613430.4369-100000@hawkeye.luckynet.adm> <Pine.GSO.4.21.0205121838230.27629-100000@weyl.math.psu.edu> <20020512225623.GG1020@louise.pinerecords.com> <3CDF1F1B.1090302@mindspring.com> <20020513104615.A10664@namesys.com> <3CDFE8DC.1090803@gointernet.co.uk> <20020513230500.A1897@namesys.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin wrote:

>>Sorry to bother you, but are you sure you spelled it correctly? The 
> 
> I am.

Sorry.

>>I have the same problem on a machine (made worse by the fact that the 
>>filesystem was a RAID0 partition).
>>I keep getting "wrong superblock", even after I told reiserfsck to 
>>rebuild the superblock.
> 
> You mean, after the --rebuild-sb command?

Yes. The first time I ran reiserfsck --rebuild-tree it told me to 
rebuild the superblock and so I ran --rebuild-sb. The startup messages 
only say the format is 3.5.x, so I selected the <=3.5.9 option

> What exactly have happened to your FS, BTW?

A complete - and so far unexplained - system freeze. The distro is SuSE 
7.3, kernel 2.4.10. I have used it at home ever since it came out 
without a single problem, so I'm quite surprised it died after a few 
days of operations just serving a Samba share and acting as a Squid 
proxy at the office (6-7 people using it, not heavy traffic).

The screen was blank and it needed a hard reboot. After the reboot I had 
the same error the initial post reported.

I do not know if the raid0 partition failed in some way and it crashed 
the system, or whether the system froze for some ther reason and the 
hard reboot messed up the partition as well - although I tend to favor 
the second case. I might have forgotten to disable APM, which on a 
number of Dell machines has given me problems (the box is an old Dell 
XPS with a 266 MHz PII). Possibly, APM kicked in and it froze the 
machine - but I'm surprised this happened after over a week of continued 
operations.


Well, I'll be very grateful for any insight you can offer

Eugenio


