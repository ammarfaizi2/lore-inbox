Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268899AbRH3ULL>; Thu, 30 Aug 2001 16:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272426AbRH3UKw>; Thu, 30 Aug 2001 16:10:52 -0400
Received: from fenrus.demon.co.uk ([158.152.228.152]:11413 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S268899AbRH3UKs>;
	Thu, 30 Aug 2001 16:10:48 -0400
Date: Thu, 30 Aug 2001 21:10:52 +0100
From: Arjan van de Ven <arjan@fenrus.demon.nl>
To: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lcs ethernet driver source
Message-ID: <20010830211052.A21173@fenrus.demon.nl>
In-Reply-To: <OF598D8FCF.4FFE0C4C-ONC1256AB8.004CFE69@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF598D8FCF.4FFE0C4C-ONC1256AB8.004CFE69@de.ibm.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Weigand <Ulrich.Weigand@de.ibm.com> wrote:
> Sorry, at this point we are not allowed to publish the source code of the
> lcs and qeth drivers (due to the use of confidential hardware interface
> specifications).  We make those modules available only in binary form
> on our developerWorks web site.

I actually believed that IBM took Open Source and the community seriously.
Not releasing key parts of the S/390 architecture port make me very 
disappointed in IBM given the very massive and public claims of support.

It makes all the fuss IBM is making about how great Linux is look, well, 
fake. I know that large parts of IBM actually do take Open Source seriously 
but it's regrettable that an influential part of the S/390 division doesn't.

> Well, you're right that without network connection, there's not much
> useful you can do.  However [.. snip ..] you can also use a CTC or IUCV
> network interface. Especially in a virtual machine, you can simply define
> a virtual CTC or IUCV connection and access your network via those
> devices.

The drivers you mention suffer a severe performance hit and are also, as I
understand them, nothing more than a sort of pipe to a proprietary driver on
the other side of the VM barrier; this is actually worse as the VM for S/390
is rather expensive. So I have the choice between not being able to
recompile the kernel while using the binary only module, and paying a lot of
money for a piece of software that isn't as fast as the direct drivers. 

This makes dwmw2@infradead.org's assertion -- that the S/390 code in the
current kernel is actually useless -- be a very valid point. Imagine Linux
for the x86 architecture had PPP as it's only open source network driver.
Wouldn't that limit its acceptance and utility ? IBM customers for S/390
might feel the same way; it will help IBM and the customers a lot if such
essential drivers were Open Source. Creative ideas by users might leverage
the S/390 platform into areas IBM didn't think of before; having all basic
parts open sourced is essential for that.

Now it's not all bad. I'm not trying to paint IBM as the corporate bad guy.
Most of IBM is doing a lot of great work for Linux and I hope that the small
part of IBM that seems to be blocking these drivers sees the light soon. If
there is anything I can do to help expedite that, just let me know.

Greetings,
   Arjan van de Ven


