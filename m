Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282156AbRKWOnd>; Fri, 23 Nov 2001 09:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282160AbRKWOnX>; Fri, 23 Nov 2001 09:43:23 -0500
Received: from jalon.able.es ([212.97.163.2]:28369 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S282156AbRKWOnU>;
	Fri, 23 Nov 2001 09:43:20 -0500
Date: Fri, 23 Nov 2001 15:43:09 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Stevie O <stevie@qrpff.net>, Vincent Sweeney <v.sweeney@dexterus.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [BUG] Bad #define, nonportable C, missing {}
Message-ID: <20011123154309.A1791@werewolf.able.es>
In-Reply-To: <01112112401703.01961@nemo> <5.1.0.14.2.20011121232051.01dab468@whisper.qrpff.net> <20011122210801.A1514@werewolf.able.es> <01112311540300.00886@manta>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <01112311540300.00886@manta>; from vda@port.imtp.ilyichevsk.odessa.ua on Fri, Nov 23, 2001 at 14:54:03 +0100
X-Mailer: Balsa 1.2.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20011123 vda wrote:
>On Thursday 22 November 2001 18:08, J.A. Magallon wrote:
>> On 20011122 Stevie O wrote:
>> >If we were going to be semiobscure, wouldn't the correct code be
>> >
>> >#define MODINC(x,y) (x = ++x % y)
>>
>> But the question is: Is this kind of code worth the discussion ? AFAIK,
>
>It worth fixing. That macro is really bad: as you can see, people cannot

That was my point, don't ever try to guess if it does what it is intended
to do, just change it.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.15-pre9 #1 SMP Thu Nov 22 16:16:54 CET 2001 i686
