Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267912AbTAHUbB>; Wed, 8 Jan 2003 15:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267916AbTAHUbB>; Wed, 8 Jan 2003 15:31:01 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:47826 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S267912AbTAHUa7>; Wed, 8 Jan 2003 15:30:59 -0500
Date: Thu, 09 Jan 2003 09:39:15 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: Fabio Massimo Di Nitto <fabbione@fabbione.net>,
       Maciej Soltysiak <solt@dns.toxicfilms.tv>
cc: Wichert Akkerman <wichert@wiggy.net>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: ipv6 stack seems to forget to send ACKs
Message-ID: <92200000.1042058355@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.51.0301082129180.12716@diapolon.int.fabbione.net>
References: <Pine.LNX.4.44.0301082122190.32244-100000@dns.toxicfilms.tv>
 <Pine.LNX.4.51.0301082129180.12716@diapolon.int.fabbione.net>
X-Mailer: Mulberry/3.0.0b10 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Probably not slow and/or overloaded.  I'd think it's more likely that it 
has a routing update problem or an unreliable link.  But whatever, this 
seemed to me to be a classic 'dodgy box in the middle' rather than an end 
host problem.

Andrew

--On Wednesday, January 08, 2003 21:31:04 +0100 Fabio Massimo Di Nitto 
<fabbione@fabbione.net> wrote:

>
> Definitly it is somehow unstable. Difficult to find the reason.
> Anyway Im sure that there is asimmetric routing between me and
> ipv6.lkml.org and I could see pkts coming back. It might not have been the
> case for Wichert
>
> Fabio
>
> On Wed, 8 Jan 2003, Maciej Soltysiak wrote:
>
>> > Probably on the server's side it got an ICMP Host Unreachable or two as
>> > some router updated its tables, and decided to close the connection.
>> Sounds reasonable to me. Could it mean that this router that we are
>> talking about is simply slow or overloaded ?
>>
>> Maciej
>>
>>
>>
>
>


