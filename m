Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312386AbSDXQpt>; Wed, 24 Apr 2002 12:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312392AbSDXQps>; Wed, 24 Apr 2002 12:45:48 -0400
Received: from exchange.macrolink.com ([64.173.88.99]:52489 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S312386AbSDXQpp>; Wed, 24 Apr 2002 12:45:45 -0400
Message-ID: <11E89240C407D311958800A0C9ACF7D13A77B8@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'David S. Miller'" <davem@redhat.com>
Cc: peterson@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: RE: PowerPC Linux and PCI
Date: Wed, 24 Apr 2002 09:45:44 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

David S. Miller wrote:
> 
>    From: Ed Vance <EdV@macrolink.com>
>    Date: Tue, 23 Apr 2002 10:16:16 -0700
> 
>    James L Peterson wrote: 
>    > What does this mean?  This suggests that PCI controller for
>    > big-endian systems are not interchangeable with PCI controllers
>    > for little-endian systems, because the controller itself does
>    > byte swapping (is that what you mean by "byte twisting"?)
>    
>    I think David's reference is to the system's PCI subsystem/interface 
>    rather than to the PCI cards plugged into it. 
> 
> No, I'm talking about the "PCI host controller" the thing that
> connects the PCI bus to the system bus :-)

Hi Dave,

Yup, same thing I was talking about. In technical terms, the thingy that 
marries the processor to the PCI bus. Some SBC's have more than one bus in
front of the PCI bus. Hmmm... I've heard that such marriages are illegal in
Texas. ;-)

Hi Jim,

Any time two unlike buses have a nexus, the nexus hardware has the major 
responsibility to resolve the issues of that nexus, whatever they may be. 
Nothing new here. Ordering of the PCI bus is always the same, as specified
in the spec, regardless of how you get there. ... And it's not always
obvious from the code what is going on in the hardware, especially if it's
_good_ hardware that makes the driver writer's life easier. 

It's all magic ...

Ed

---------------------------------------------------------------- 
Ed Vance              edv@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------

