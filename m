Return-Path: <linux-kernel-owner+w=401wt.eu-S932545AbXAGOTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545AbXAGOTI (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 09:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbXAGOTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 09:19:08 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:6652 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932545AbXAGOTH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 09:19:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PuBKgaBTyc3CEQX3zQvN/WOE5juJWEJukAfbhxpRGH1NfKafkTPewZftkTJr+Ty90XuTmA6ziIY6F0eEBtE+Ylkxzag3T2Nc3AcSUQkjCVUxzETagv9tPl7kG5HWIZd9R3sX+iQ+fj4h9gsPZb7qO964G7ReENOUxftelbkkMQc=
Message-ID: <8355959a0701070619w19dd79a5r5ccfdd1121e6a52b@mail.gmail.com>
Date: Sun, 7 Jan 2007 19:49:05 +0530
From: Akula2 <akula2.shark@gmail.com>
To: "Willy Tarreau" <w@1wt.eu>
Subject: Re: Multi kernel tree support on the same distro?
Cc: "Steve Brueggeman" <xioborg@mchsi.com>,
       "Auke Kok" <sofar@foo-projects.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20070107132054.GA435@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <8355959a0701041146v40da5d86q55aaa8e5f72ef3c6@mail.gmail.com>
	 <459D9872.8090603@foo-projects.org>
	 <tekrp2tqo78uh6g2pjmrhe0vpup8aalpmg@4ax.com>
	 <20070107093057.GS24090@1wt.eu>
	 <8355959a0701070511v55c671dibc3bb7d4426129e0@mail.gmail.com>
	 <20070107132054.GA435@1wt.eu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > On 1/7/07, Willy Tarreau <w@1wt.eu> wrote:
> I don't see which libs you are talking about. The compiler you build your
> kernel with is totally independant on the compiler you build your apps with.
> A few years ago, some distros even shipped a compiler just for the kernel
> (they called the binary "kgcc").
>
> So you just have to build 2 different GCC, one for 2.4, one for 2.6 and
> you use them to build your kernels. If you want yet another compiler for
> your apps, simply do it, it's not a problem. For instance, look on my
> system when I type gcc- <Tab> :

Sorry for the typo & confusion caused. I meant in that example as:-

myArmWireless app. compiled with gcc-3.4.x, NOT gcc-4.1.x compiler on
say 2.4.34 kernel (assuming I can build 4.1.x on 2.4.34 kernel).

Now, I've got it about this app funda. Ok! Am coming closer now. I
have these 2 tasks:-

a) Since 2.6 kernel has no issues with gcc-3.4.x, gcc-4.1.x. So I will
build them. No probs here.

b) 2.4 kernel has no issues with gcc-3.4.x to my understanding, but am
not sure about compiling it with gcc-4.1.x? If this is true, how to
build this?

Whole idea is to have 2 compilers (gcc-3.4.x, gcc-4.1.x) on the both
the kernels.


> > Hope you guys consider these (my) questions as Novice, because am
> > trying to figure a design @ How-To build such multi kernel/gcc
> > systems.
>
> Well, I hope it will help you
> Willy

Thanks,
~Akula2
