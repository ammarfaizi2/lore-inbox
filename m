Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132409AbQKKUeM>; Sat, 11 Nov 2000 15:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132374AbQKKUeC>; Sat, 11 Nov 2000 15:34:02 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:9 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132409AbQKKUdp>; Sat, 11 Nov 2000 15:33:45 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Q: Linux rebooting directly into linux.
Date: 11 Nov 2000 12:33:15 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8ukaeb$eh6$1@cesium.transmeta.com>
In-Reply-To: <m17l6deey7.fsf@frodo.biederman.org> <20001109113524.C14133@animx.eu.org> <m1g0kycm0x.fsf@frodo.biederman.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <m1g0kycm0x.fsf@frodo.biederman.org>
By author:    ebiederm@xmission.com (Eric W. Biederman)
In newsgroup: linux.dev.kernel
> > > 
> > > The interface is designed to be simple and inflexible yet very
> > > powerful.  To that end the code just takes an elf binary, and a
> > > command line.  The started image also takes an environment generated
> > > by the kernel of all of the unprobeable hardware details.
> > 
> > Isn't this what milo does on alpha?
> 
> Similar milo uses kernel drivers in it's own framework.  
> This has proved to be a major maintenance problem.  Milo is nearly
> a kernel fork.  
> 
> The design is for the long term to get this incorporated into the
> kernel, and even if not a small kernel patch should be easier to
> maintain that a harness for calling kernel drivers.
> 

I'm working on something similiar in "Genesis".  It pretty much is (or
rather, will be) a kernel *port*, not a fork; the port is such that it
can run on top of a simple BIOS extender and thus access the boot
media.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
