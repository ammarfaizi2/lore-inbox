Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267496AbSLLUte>; Thu, 12 Dec 2002 15:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267498AbSLLUte>; Thu, 12 Dec 2002 15:49:34 -0500
Received: from smtp08.iddeo.es ([62.81.186.18]:59349 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id <S267496AbSLLUtd>;
	Thu, 12 Dec 2002 15:49:33 -0500
Date: Thu, 12 Dec 2002 21:56:55 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Mark Mielke <mark@mark.mielke.cc>
Cc: Terje Eggestad <terje.eggestad@scali.com>,
       "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@codemonkey.org.uk>
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021212205655.GA1658@werewolf.able.es>
References: <1039610907.25187.190.camel@pc-16.office.scali.no> <3DF78911.5090107@zytor.com> <1039686176.25186.195.camel@pc-16.office.scali.no> <20021212203646.GA14228@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20021212203646.GA14228@mark.mielke.cc>; from mark@mark.mielke.cc on Thu, Dec 12, 2002 at 21:36:46 +0100
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.12.12 Mark Mielke wrote:
>On Thu, Dec 12, 2002 at 10:42:56AM +0100, Terje Eggestad wrote:
>> On ons, 2002-12-11 at 19:50, H. Peter Anvin wrote:
>> > Terje Eggestad wrote:
>> > > PS:  rdtsc on P4 is also painfully slow!!!
>> > Now that's just braindead...
>> It takes about 11 cycles on athlon, 34 on PII, and a whooping 84 on P4.
>> For a simple op like that, even 11 is a lot... Really makes you wonder.
>
>Some of this discussion is a little bit unfair. My understanding of what
>Intel has done with the P4, is create an architecture that allows for
>higher clock rates. Sure the P4 might take 84, vs PII 34, but how many
>PII 2.4 Ghz machines have you ever seen on the market?
>
>Certainly, some of their decisions seem to be a little odd on the surface.
>
>That doesn't mean the situation is black and white.
>

No. The situation is just black. Each day Intel processors are a bigger
pile of crap and less intelligent, but MHz compensate for the average
office user. Think of what could a P4 do if the same effort put on
Hz was put on getting cheap a cache of 4Mb or 8Mb like MIPSes have. Or
closer, 1Mb like G4s.
If syscalls take 300% time but processor is also 300% faster 'nobody
notices'. 

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-jam1 (gcc 3.2 (Mandrake Linux 9.1 3.2-4mdk))
