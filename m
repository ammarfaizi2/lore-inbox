Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318452AbSGSHdx>; Fri, 19 Jul 2002 03:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318457AbSGSHdx>; Fri, 19 Jul 2002 03:33:53 -0400
Received: from [195.63.194.11] ([195.63.194.11]:25360 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S318452AbSGSHdw>; Fri, 19 Jul 2002 03:33:52 -0400
Message-ID: <3D37C03C.6000301@evision.ag>
Date: Fri, 19 Jul 2002 09:31:08 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020625
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Daniel Phillips <phillips@arcor.de>, linux-kernel@vger.kernel.org
Subject: Re: Remain Calm: Designated initializer patches for 2.5
References: <20020719014425.BAECB417E@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> In message <E17VBcZ-0004oO-00@starship> you write:
> 
>>On Thursday 18 July 2002 05:22, Rusty Russell wrote:
>>
>>>GCC has understood both since forever, but the kernel took a wrong
>>>bet, and we're better off setting a good example for 2.6 before we
>>>start getting about 10,000 warnings.
>>
>>Next time, remember to bet on the ugliest looking one ;-)
> 
> 
> I agreed, until I recently did a big grep to find these things.  I now
> concur with the C9X committee.  ".foo = " is clearly distinguished
> from bitfield declarations and labels, which "foo: " isn't.

Of hand I think about the following *technical* points:

1. It resembles the usage case similar to other initalizations.

2. It makes for less reduce/reduce conflicts in the LR-grammar
parser generator.

Its better and more outtought then the GNU "extension".



