Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314388AbSDRQKq>; Thu, 18 Apr 2002 12:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314389AbSDRQKp>; Thu, 18 Apr 2002 12:10:45 -0400
Received: from [213.250.49.39] ([213.250.49.39]:6789 "EHLO godzila.nuedi.com")
	by vger.kernel.org with ESMTP id <S314388AbSDRQKo>;
	Thu, 18 Apr 2002 12:10:44 -0400
Message-ID: <02be01c1e6f3$94bbc6a0$0201a8c0@nuedi.com>
From: "Vasja J Zupan" <vasja@nuedi.com>
To: "Etienne Lorrain" <etienne_lorrain@yahoo.fr>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <20020418155943.93909.qmail@web11802.mail.yahoo.com>
Subject: Re: HPT372 on KR7A-133R (ATA133) on production server
Date: Thu, 18 Apr 2002 18:10:37 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok,
I see, what CPU do you use? I'm planning to go for Athlon XP 1800+.
I do not see my services would use 100% CPU at any time but I cannot be 100%
certain!
I'll add 512MB DDR PC266 RAM (vendor unknown at this time).

I also plan to add raiserfs for two mirror 40GB WD ata100 7200rpm.

Any suggestions?

rgds,
Vasja

----- Original Message -----
From: "Etienne Lorrain" <etienne_lorrain@yahoo.fr>
To: <linux-kernel@vger.kernel.org>
Cc: <vasja@nuedi.com>
Sent: Thursday, April 18, 2002 5:59 PM
Subject: Re: HPT372 on KR7A-133R (ATA133) on production server


>   I have this exact motherboard, with CRUCIAL 256MB 184DIMM PC2100 NP
CL2.5
>  memory.
>  You first have to patch your kernel like Andy Jeffries said to activate
>  the RAID controller. Most of the distribution still did not do it,
>  you probably have to compile your own kernel.
>
>  For a long time, I have only been able to run it 100% CPU for one hour,
>  no disk access, if I set the memory clock to 100/200 MHZ.
>
>  I am currently experimenting running at 133/266 MHz with the two
>  parameters "DDR DQS Input Delay" and "DDR DQS Output Delay" changed
>  to manual and increased by 2.
>  Their autodetection does not seem to work, I am not sure.
>  It seems stable - no error noticed for the last few weeks.
>  Note that 100/200 to 133/266 did not seem to increase the CPU speed
>  a lot, my usual task takes 39 minutes 100% CPU in 133/266 and
>  40 min in 100/200 mode.
>  I am not on a production server, so your millage may vary.
>
>   Just my ?0.02,
>   Etienne.
>
> ___________________________________________________________
> Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
> Yahoo! Mail : http://fr.mail.yahoo.com
>

