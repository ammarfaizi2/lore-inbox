Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264920AbSJPEhw>; Wed, 16 Oct 2002 00:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264921AbSJPEhw>; Wed, 16 Oct 2002 00:37:52 -0400
Received: from adsl-67-64-81-217.dsl.austtx.swbell.net ([67.64.81.217]:3205
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S264920AbSJPEhu>; Wed, 16 Oct 2002 00:37:50 -0400
Subject: Re: [Kernel 2.5] Qlogic 2x00 driver
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: J Sloan <joe@tmsusa.com>
Cc: Michael Clark <michael@metaparadigm.com>,
       Simon Roscic <simon.roscic@chello.at>,
       Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3DACEC85.3020208@tmsusa.com>
References: <200210152120.13666.simon.roscic@chello.at>
	 <1034710299.1654.4.camel@localhost.localdomain>
	 <200210152153.08603.simon.roscic@chello.at>
	 <3DACD41F.2050405@metaparadigm.com> <1034740592.29313.0.camel@localhost>
	 <3DACEB6E.6050700@metaparadigm.com>  <3DACEC85.3020208@tmsusa.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1034743416.29307.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.2.99 (Preview Release)
Date: 15 Oct 2002 23:43:46 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My Dell 6650 has been doing this exact behaviour since we got on 5.38.9
and up, using LVM in a production capacity. Both servers we have, have
crashed mysteriously, without any kernel dump, etc, but all hardware
diags come out clean.

All hardware configuration bits are perfect, as can be anyway, and we
still get this behaviour. After 5-6.5 days...the box black screens. So
bad so, that all the XFS volumes we have, never enter a shutdown. We
must repair them all, today this happened, and we lost one part of the
tablespace on our beta db. We're using LVM1, on 2.4.19-aa1.




On Tue, 2002-10-15 at 23:35, J Sloan wrote:
> Just to make sure we are on the same page,
> was that LVM1, LVM2, or EVMS?
> 
> Joe
> 
> Michael Clark wrote:
> 
> > I doubt it will make a difference. LVM and qlogic drivers seem
> > to be a bad mix. I've already tried the beta5 of 6.01
> > and same problem exists - ooops about every 5-8 days.
> > Removing LVM and solved the problem.
> 
> 
> 
