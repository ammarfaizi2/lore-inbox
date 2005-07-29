Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262692AbVG2SNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262692AbVG2SNN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 14:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262697AbVG2SM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 14:12:57 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:28831 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S262692AbVG2SKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 14:10:39 -0400
In-Reply-To: <Pine.OSF.4.05.10507291900320.26224-100000@da410.phys.au.dk>
References: <Pine.OSF.4.05.10507291900320.26224-100000@da410.phys.au.dk>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B8CF930D-1C47-40AD-B936-D68AE007FE07@freescale.com>
Cc: "Matt Porter" <mporter@kernel.crashing.org>,
       "Michael Richardson" <mcr@sandelman.ottawa.on.ca>,
       "Gala Kumar K.-galak" <galak@freescale.com>,
       "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH 00/14] ppc32: Remove board ports that are no longer maintained
Date: Fri, 29 Jul 2005 13:10:23 -0500
To: Esben Nielsen <simlo@phys.au.dk>
X-Mailer: Apple Mail (2.733)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jul 29, 2005, at 12:03 PM, Esben Nielsen wrote:

>
>
> On Wed, 27 Jul 2005, Matt Porter wrote:
>
>
>> On Wed, Jul 27, 2005 at 09:27:41AM -0700, Eugene Surovegin wrote:
>>
>>> On Wed, Jul 27, 2005 at 12:13:23PM -0400, Michael Richardson wrote:
>>>
>>>> Kumar, I thought that we had some volunteers to take care of some
>>>>
> of
>
>>>> those. I know that I still care about ep405, and I'm willing to
>>>>
> maintain
>
>>>> the code.
>>>>
>>>
>>> Well, it has been almost two months since Kumar asked about
>>>
> maintenance
>
>>> for this board. Nothing happened since then.
>>>
>>> Why is it not fixed yet? Please, send a patch which fixes it. This
>>>
> is
>
>>> the _best_ way to keep this board in the tree, not some empty
>>> maintenance _promises_.
>>>
>>
>> When we recover our history from the linuxppc-2.4/2.5 trees we can
>> show exactly how long it's been since anybody touched ep405.
>>
>> Quick googling shows that it's been almost 2 years since the last
>> mention of ep405 (exluding removal discussions) on linuxppc-embedded.
>> Last ep405-related commits are more than 2 years ago.
>>
>>
> I don't follow that reasoning. Even broken drivers(board support  
> files,
> whateever) are better than non.
>
> Take ArcNet support forinstance. Clearly it hadn't been used in any  
> 2.6
> kernel up until around 2.6.10. It was highly broken (call to
> uninitialized function pointer). But I needed it. I fixed it and send
> the
> patch so it works from 2.6.11 and up.  If the driver had been  
> dropped in
> the 2.6 series because nobody actively maintained it, I  wouldn't have
> got
> around to fix it at all and was probably forced to use another OS  
> for my
> perpose.
>
> But because the driver was still in there and somebody had made  
> sure it
> was updated along the changes to the API in the 2.6 kernel, it was  
> easy
> for me to fix it although I didn't know so much about the kernel
> internals
> at that time.

The code will still exist in older kernel releases so if someone  
needs to bring it up to date they can.  We are more than willing to  
take patches to fix any issues.

Let's be clear.  I posted a request several weeks ago in which anyone  
was free to comment on the various board ports that existed and their  
maintainership.

- kumar
