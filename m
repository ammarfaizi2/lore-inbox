Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287595AbSAPVC7>; Wed, 16 Jan 2002 16:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287552AbSAPVCw>; Wed, 16 Jan 2002 16:02:52 -0500
Received: from eventhorizon.antefacto.net ([193.120.245.3]:5252 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S287545AbSAPVCj>; Wed, 16 Jan 2002 16:02:39 -0500
Message-ID: <3C45E95A.2010802@antefacto.com>
Date: Wed, 16 Jan 2002 20:58:02 +0000
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: AstinusLists <AstinusLists@netcabo.pt>
CC: linux-kernel@vger.kernel.org
Subject: Re: ISDN CHANNEL-D
In-Reply-To: <001d01c19ec5$b6f8f740$d500a8c0@mshome.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AstinusLists wrote:

> Hello every one.
> 
> I've been earing some rumors, that i am quite sure that are turth about the
> isdn channel d.
> 
> As all of u know ( i think ) isdn cards have 3 channels: 2*64 and one time
> 16 kbs.
> 
> This last one is called channel D.
> Channel D is used to dial and to reply to tones and minor stuff like that.
> 
> The big deal here in my country is that u don't have to pay for the channel
> D traffic ( And it is legal to use it, i can assure that, cause i am well
> informed on that matter!)


Yes info is passed across the D channel in messages. There is a message

type called User User information that can be passed, but only with and
associated D channel call type, i.e. you must pay for it.

Also other "standard" messages like "call setup", "progress", ... can
contain user user info, but these can only be transfer after the call
is established.

In both cases an explicit call must be established first, so you're
billed for such traffic.

Now I suppose you could set specific bits in standard call setup 
messages for e.g. that could be used to transfer info between
users, but I'd say about 10bits max per call setup? which is not
interesting.

Search the net for Q931 for ISDN D channel protocol spec.

What does this have to do with Linux again?


Padraig.


