Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272528AbRISSXm>; Wed, 19 Sep 2001 14:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274130AbRISSXf>; Wed, 19 Sep 2001 14:23:35 -0400
Received: from as4-1-7.has.s.bonet.se ([217.215.31.238]:15539 "EHLO
	k-7.stesmi.com") by vger.kernel.org with ESMTP id <S272528AbRISSXY>;
	Wed, 19 Sep 2001 14:23:24 -0400
Message-ID: <3BA8E252.3060802@stesmi.com>
Date: Wed, 19 Sep 2001 20:22:10 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: safemode <safemode@speakeasy.net>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Athlon bug stomper. Pls apply.
In-Reply-To: <20010919154701.A7381@stud.ntnu.no> <20010919165503.A16359@gondor.com> <9oafeu$1o0$1@penguin.transmeta.com> <20010919171454Z274108-760+14176@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.



>>Which means that the "statistical sampling" is very skewed by
>>self-selection, and anybody who knows anything about statistics knows
>>that sample selection is _very_ important.
>>
> the only way it'll get a good sampling is to put it in the kernel 
> I suggest not adding this to the "athlon" cpu selection code.  Rather make it 
> a sub-option like many other drivers have.  That way people can select 
> whether they need it or not until we are sure it's totally safe for everyone 
> to use it by Via saying so or something.   Just a suggestion, other drivers 
> do the same thing, so why not the cpu selection screen for workarounds. 

Why not simply add it to the next -pre cycle (if 2.4.10 is nearby), ie 
2.4.11-pre1 has it, it goes through a few revisions of -pre and if it's 
stable enough for mainstream, have it standard for 2.4.11, otherwise 
just drop it, fix it, squash it, or do whatever with it :)

And if 2.4.10 isn't that close, add it to -pre13 and do the same, having 
it permanently in 2.4.10 (or not if it's nuclear).

// Stefan


