Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267592AbUH0TiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267592AbUH0TiT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 15:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267584AbUH0Th3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 15:37:29 -0400
Received: from [195.23.16.24] ([195.23.16.24]:27324 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S267600AbUH0Te4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 15:34:56 -0400
Message-ID: <412F8CDD.7030107@grupopie.com>
Date: Fri, 27 Aug 2004 20:34:53 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>, greg@kroah.com,
       nemosoft@smcc.demon.nl, linux-usb-devel@lists.sourceforge.net,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: pwc+pwcx is not illegal
References: <1093634283.431.6370.camel@cube>
In-Reply-To: <1093634283.431.6370.camel@cube>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.6; VDF: 6.27.0.35; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
> Paulo Marques writes:
> 
> 
>>About the legal aspects of all this, they have been
>>discussed extensively in the past. It is not about
>>"hey this is just a simple hook", it is all about
>>the derived work concept. This driver does absolutely
>>nothing outside the kernel. It's only purpose is to
>>attach itself to the kernel and to provide the images
>>from the camera to userspace using the kernel ABI's.
>>So you can not say it is not a derived work at all.
> 
> 
> (note: the following is not legal advice)
> 
> I think you'll find that this is not supported by
> the copyright law, at least in the United States and
> in any sane country.
> 
> Richard Stallman and The SCO Group might like your
> interpretation, at least when it serves them, but
> that doesn't make it the law.

You're completely missing the point. I never said that the pwcx driver 
copies code from the kernel, and in doing so infringes copyright law.

What I'm saying is that the kernel is distributed with a license that 
allows you certain rights, and that extending the kernel functionality 
through closed source drivers is not one of those rights.

> What protectable elements of the kernel have been
> included within the driver? I don't see any.
> Like we say to SCO, where are the lines of code?
> Remember, nobody is distributing a kernel with
> this driver linked in. Merely loading the driver
> is obviously fair use of the kernel.
> 
> (BTW, something which is required for operation
> is not protectable. See the Sega v. Accolade case.
> Thus, mere usage of header files won't do. You
> couldn't even use the C header files on any UNIX
> system if that were the case. Let's not be silly.)

You're being silly, I've never said anything about header files, nor 
copied lines of code.

> Is it "non-literal copying" that concerns you?
> Heh. OK. Name the jurisdiction you like, and
> describe the copyright infringement test accepted
> by the courts in that jurisdiction.
> 
> For example, the US 10th Circuit uses the "abstraction,
> filtration, comparison" test. The US 9th Circuit uses
> the "Analytic Dissection" test. There are others.
> I don't know of any such test under which the
> closed-source part of the driver could be considered
> to be a derived work of the Linux kernel. I can hardly
> imagine one that would make the driver derived without
> also making Linux derived from UNIX!
> 
> So anyway... where are the lines of code?

It is a derived work, not a "copied" work. The point is:

 >>This driver does absolutely
 >>nothing outside the kernel. It's only purpose is to
 >>attach itself to the kernel and to provide the images
 >>from the camera to userspace using the kernel ABI's.

In the case of a nvidia driver (for instance) one can argue that the 
driver was written for another well known closed source operating 
system, and was latter ported to Linux, so that we can not honestly say 
that it is a derived work.

Anyway, this is all a big gray area, with darker and lighter tones of 
gray. So you only get a definite answer in front of a judge.

This whole discussion has been beaten to death in the past. I really 
don't want to go through that again. Although I have not been directly 
involved in the past discussion, the traffic in LKML is high enough that 
it doesn't need another one of those threads...

-- 
Paulo Marques - www.grupopie.com

To err is human, but to really foul things up requires a computer.
Farmers' Almanac, 1978
