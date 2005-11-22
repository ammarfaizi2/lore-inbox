Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964996AbVKVRfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbVKVRfm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 12:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbVKVRfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 12:35:42 -0500
Received: from quark.didntduck.org ([69.55.226.66]:28609 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S964996AbVKVRfl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 12:35:41 -0500
Message-ID: <43835772.9070204@didntduck.org>
Date: Tue, 22 Nov 2005 12:37:54 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mail/News 1.5 (X11/20051105)
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Avi Kivity <avi@argo.co.il>, Jon Smirl <jonsmirl@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Airlie <airlied@gmail.com>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Small PCI core patch
References: <1132616132.26560.62.camel@gaston> <21d7e9970511211647r4df761a2l287715368bf89eb6@mail.gmail.com> <1132623268.20233.14.camel@localhost.localdomain> <1132626478.26560.104.camel@gaston> <9e4733910511211923r69cdb835pf272ac745ae24ed7@mail.gmail.com> <43833D61.9050400@argo.co.il> <20051122155143.GA30880@havoc.gtf.org> <43834400.3040506@argo.co.il> <20051122162506.GA32684@havoc.gtf.org> <438349F4.2080405@argo.co.il> <20051122165638.GE32684@havoc.gtf.org>
In-Reply-To: <20051122165638.GE32684@havoc.gtf.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> On Tue, Nov 22, 2005 at 06:40:20PM +0200, Avi Kivity wrote:
>> Jeff Garzik wrote:
>>
>>> On Tue, Nov 22, 2005 at 06:14:56PM +0200, Avi Kivity wrote:
>>>
>>>
>>>> You exaggerate. Windows drivers work well enough in Windows (or so I 
>>>> presume). One just has to implement the environment these drivers 
>>>> expect, very carefully.
>>>>   
>>>>
>>> I exaggerate nothing -- we have real world experience with ndiswrapper
>>> and similar software, which is exactly the same model you proposed, is
>>> exactly the same model that has created all sorts of technical, legal,
>>> and political problems.
>>>
>>>
>> I agree that the legal and political problems are real. I offered two 
>> solutions to the technical problems.
> 
> And given real world experience with "solutions" like this, they cause
> more problems than they solve.
> 
> 
>> However the situation with video drivers is already bad, and 
>> deteriorating. I had to hunt on the Internet to get my recent (FC4) 
>> distro to support my low-end embedded video (via). In the future it 
>> looks like even that won't work.
> 
> VIA is working with open source community.  They are small enough
> (comparatively) that they need every advantage.  VIA is one of the
> positive examples.
> 

The biggest problem with VIA (and Intel) is that they are only available 
as integrated video on the motherboard.  I can't just walk to the store 
and pick one up off the shelf.  I have yet to see any AMD64 motherboards 
with these chipsets either.

--
				Brian Gerst
