Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284258AbRLMPeI>; Thu, 13 Dec 2001 10:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284280AbRLMPd6>; Thu, 13 Dec 2001 10:33:58 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:56130 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S284258AbRLMPdw>; Thu, 13 Dec 2001 10:33:52 -0500
Date: Thu, 13 Dec 2001 09:33:28 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200112131533.JAA51038@tomcat.admin.navo.hpc.mil>
To: riel@conectiva.com.br, James Simmons <jsimmons@transvirtual.com>
Subject: Re: [OT] DRM OS 
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br>:
> 
> On Wed, 12 Dec 2001, James Simmons wrote:
> 
> > Microsoft patents loading a trusted OS into a trusted CPU. The OS prevents
> > untrusted applications from accessing Rights Managed Data.
> 
> I haven't looked up the link, but this sounds suspiciously like
> what UNIX permission bits have been doing since the 1970s.
> 
> I guess MS trying to enforce their patent against anyone would
> just get it invalidated, or the claim is narrow enough that
> people can work around it.
> 
> > http://patft.uspto.gov/netacgi/nph-Parser?Sect1=PTO2&Sect2=HITOFF&p=1&u=/netahtml/search-adv.htm&r=1&f=G&l=50&d=CR99&S1=5,892,900.UREF.&OS=ref/5,892,900&RS=REF/5,892,900
> 
> Then again, this only applies to people unlucky enough to live
> in the US. No need to worry.

Besides, there are several technical flaws in the patent itself. First
and formost is that it isn't new (check the Orange book on trusted computer
systems and object reuse). It doesn't include the memory controled by
peripherals - graphics frame buffers and device cache buffers - (the TSEC
object reuse specifications do).

It doesn't even include controlling access to the "trusted OS".

If it did, then owners/users would no longer be able to apply any of the
hundreds of patches such a system (if from M$) would require...:-)

Never mind having access to a "trusted time server" by a disconnected laptop.

Or defining what happens under a power failure...

I wouldn't expect this to last even a first challenge, as long as the
governments own documents were presented as "prior art".

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
