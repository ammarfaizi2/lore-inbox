Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264900AbSJPGZw>; Wed, 16 Oct 2002 02:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264910AbSJPGZw>; Wed, 16 Oct 2002 02:25:52 -0400
Received: from adsl-67-64-81-217.dsl.austtx.swbell.net ([67.64.81.217]:28037
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S264900AbSJPGZv>; Wed, 16 Oct 2002 02:25:51 -0400
Subject: Re: [Kernel 2.5] Qlogic 2x00 driver
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: Michael Clark <michael@metaparadigm.com>
Cc: J Sloan <joe@tmsusa.com>, Simon Roscic <simon.roscic@chello.at>,
       Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3DAD0118.80807@metaparadigm.com>
References: <200210152120.13666.simon.roscic@chello.at>
	 <1034710299.1654.4.camel@localhost.localdomain>
	 <200210152153.08603.simon.roscic@chello.at>
	 <3DACD41F.2050405@metaparadigm.com> <1034740592.29313.0.camel@localhost>
	 <3DACEB6E.6050700@metaparadigm.com>  <3DACEC85.3020208@tmsusa.com>
	 <1034743416.29307.11.camel@localhost>  <3DAD0118.80807@metaparadigm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1034749907.2045.15.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.2.99 (Preview Release)
Date: 16 Oct 2002 01:31:47 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-16 at 01:03, Michael Clark wrote:
> On 10/16/02 12:43, GrandMasterLee wrote:
> > My Dell 6650 has been doing this exact behaviour since we got on 5.38.9
> > and up, using LVM in a production capacity. Both servers we have, have
> > crashed mysteriously, without any kernel dump, etc, but all hardware
> > diags come out clean.
> 
> I tell you my honest hunch - remove LVM and try again. This has made
> my life a little more peaceful lately. Even with a 2-3 minute outages
> while our cluster automatically fails over - the 100's of users whining
> about their sessions being disconnected makes you a bit depressed.

Almost making it to your go-live date, only to have everything come
crashing down all around you is quite depressing.

> > All hardware configuration bits are perfect, as can be anyway, and we
> > still get this behaviour. After 5-6.5 days...the box black screens. So
> > bad so, that all the XFS volumes we have, never enter a shutdown. We
> > must repair them all, today this happened, and we lost one part of the
> > tablespace on our beta db. We're using LVM1, on 2.4.19-aa1.
> 
> We had the black screen also until we got the machines oopsing over
> serial. The oops was actually showing up in ext3 with a corrupted
> bufferhead. Without LVM, i've measured my longest uptime, 17 days x
> 4 machines in the cluster (68 days) ie. we only did it 17 days ago.
> 
> ~mc


I believe you, that was my next thought, but I didn't know if that would
really help just to be honest. Thanks for the input there. 

I've been going crazy trying to catch any piece of sanity out of this
thing to understand if this was what was happening or not. I feel a bit
dumb for not trying serial console yet, but I knew either that or KDB
should tell us something. I will see what we can do, it will take less
time to do this, than to reload everything all over again.

Should I remove LVM all together, or just not use it? In your opinion.


