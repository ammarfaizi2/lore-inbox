Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264929AbSJPGm6>; Wed, 16 Oct 2002 02:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264932AbSJPGm6>; Wed, 16 Oct 2002 02:42:58 -0400
Received: from adsl-67-64-81-217.dsl.austtx.swbell.net ([67.64.81.217]:29829
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S264929AbSJPGm5>; Wed, 16 Oct 2002 02:42:57 -0400
Subject: Re: [Kernel 2.5] Qlogic 2x00 driver
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: Michael Clark <michael@metaparadigm.com>
Cc: J Sloan <joe@tmsusa.com>, Simon Roscic <simon.roscic@chello.at>,
       Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3DAD09E3.2050602@metaparadigm.com>
References: <200210152120.13666.simon.roscic@chello.at>
	 <1034710299.1654.4.camel@localhost.localdomain>
	 <200210152153.08603.simon.roscic@chello.at>
	 <3DACD41F.2050405@metaparadigm.com> <1034740592.29313.0.camel@localhost>
	 <3DACEB6E.6050700@metaparadigm.com>  <3DACEC85.3020208@tmsusa.com>
	 <1034743416.29307.11.camel@localhost>  <3DAD0118.80807@metaparadigm.com>
	 <1034749907.2045.15.camel@localhost>  <3DAD09E3.2050602@metaparadigm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1034750930.2045.35.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.2.99 (Preview Release)
Date: 16 Oct 2002 01:48:53 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-16 at 01:40, Michael Clark wrote:
...
> > Should I remove LVM all together, or just not use it? In your opinion.
> 
> I just didn't load the module after migrating my volumes. If the problem
> is a stack problem, then its probably not necessarily a bug in LVM
> - just the combination of it, ext3 and the qlogic driver don't mix well
> - so if its not being used, then it won't be increasing the stack footprint.
> 
> ~mc
> 

Not to be dense, but it's compiled into my kernel, that's why I ask. We
try not to use modules where we can help it. So I'm thinking, if no VG
are actively used, then LVM won't affect the stack much. I just don't
know if that's true or not. 

 --The GrandMaster
