Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132516AbRDARfm>; Sun, 1 Apr 2001 13:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132520AbRDARfc>; Sun, 1 Apr 2001 13:35:32 -0400
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:64874 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S132516AbRDARfP>; Sun, 1 Apr 2001 13:35:15 -0400
Date: Sun, 1 Apr 2001 12:34:24 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Constantine Gavrilov <const-g@optibase.com>
cc: Anton.Safonov@bestlinux.net, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PCMCIA problems on IBM ThinkPad 600X
In-Reply-To: <3AC73AE6.9070701@optibase.com>
Message-ID: <Pine.LNX.3.96.1010401123249.28121B-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Apr 2001, Constantine Gavrilov wrote:
> There are problems with some PCMCIA drivers included in the kernel. For 
> example, support for cardbus 3com cards was moved to 3c59x.o driver. It 
> works (on 600X at least) only of you compile it in. It will not work as 
> a module.

It works just fine as a module.  What problems are you seeing?


> I think a much better solution right now is to use drivers from 
> pcmcia-cs package. It always works. If you do not configure any support 
> for pcmcia in your kernel, when you build pcmcia-cs it will build kernel 
> drivers from its own source tree. Just make sure you use the latest 
> version. This also allows configuration files interoperbility with 2.2.x 
> kernel, if you wish to use that as well.

pcmcia-cs does not always work, and it puts your nice 32-bit hardware
into 16-bit compatibility mode AFAIK.

If you have 2.4 bugs, please report them instead of spewing B.S.

	Jeff



