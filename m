Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261997AbTCRGYq>; Tue, 18 Mar 2003 01:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262178AbTCRGYq>; Tue, 18 Mar 2003 01:24:46 -0500
Received: from otter.mbay.net ([206.55.237.2]:6919 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S261997AbTCRGYp> convert rfc822-to-8bit;
	Tue, 18 Mar 2003 01:24:45 -0500
From: John Alvord <jalvo@mbay.net>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63))
Date: Mon, 17 Mar 2003 22:35:26 -0800
Message-ID: <sffd7vk3otsn0s7uhgvu1gkp2v0q6qv0cq@4ax.com>
References: <200303172143.h2HLhLql010853@pincoya.inf.utfsm.cl> <200303180608.h2I68mu23488@Port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200303180608.h2I68mu23488@Port.imtp.ilyichevsk.odessa.ua>
X-Mailer: Forte Agent 1.92/32.570
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Mar 2003 08:05:30 +0200, Denis Vlasenko
<vda@port.imtp.ilyichevsk.odessa.ua> wrote:

>On 17 March 2003 23:43, Horst von Brand wrote:
>> Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> said:
>> > On 15 March 2003 20:34, Horst von Brand wrote:
>> > > Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> said:
>>
>> [...]
>>
>> > > > Why not? Disassemble from, say, EIP-16 and check whether you
>> > > > have an instruction starting exactly at EIP. If no, repeat from
>> > > > EIP-15, -14... You are guaranteed to succeed at EIP-0  ;)
>> > >
>> > > But your previous success (if any) doesn't mean anything, and
>> > > might even screw up the decoding after EIP
>> >
>> > How come? If I started to decode at EIP-n and got a sequence of
>> > instructions at EIP-n, EIP-n+k1, EIP-n+k2, EIP-n+k3..., EIP,
>> > instructions prior to EIP can be wrong. Instruction at EIP
>> > and all subsequent ones ought to be right.
>>
>> Iff you exactly hit EIP that way (sure, should check). But wrong
>> previous instructions _will_ confuse people or start them on all kind
>> of wild goose chases. Too much work for a dubious gain.
>
>You are right. But that is better than showing no prior instructions
>at all. And most of the time (can I say 90% ?) prior instructions
>will be ok.

You can also show the instruction sequences that make sense and let
the human figure out the correct sequence when there are multiples.

john
