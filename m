Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263870AbSIQHto>; Tue, 17 Sep 2002 03:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263874AbSIQHto>; Tue, 17 Sep 2002 03:49:44 -0400
Received: from 62-190-219-123.pdu.pipex.net ([62.190.219.123]:1540 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S263870AbSIQHtn>; Tue, 17 Sep 2002 03:49:43 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209170802.g8H82CTZ000701@darkstar.example.net>
Subject: Re: Hi is this critical??
To: nuitari@balthasar.nuitari.net (Nuitari)
Date: Tue, 17 Sep 2002 09:02:12 +0100 (BST)
Cc: venom@sns.it, linux-kernel@vger.kernel.org, xavier.bestel@free.fr,
       mark@veltzer.org
In-Reply-To: <Pine.LNX.4.44.0209170114580.20176-100000@balthasar.nuitari.net> from "Nuitari" at Sep 17, 2002 01:18:01 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 17 Sep 2002 venom@sns.it wrote:
> 
> > On Mon, 16 Sep 2002 jbradford@dial.pipex.com wrote:
> > 
> > >
> > > S.M.A.R.T. is useful to prove that a drive is dying, but it is not useful to prove that it is not.
> > 
> > Yes, of course, and this was exaclty what was asked here in the mail
> > from xavier that started this thread. The point is if S.M.A.R.T will
> > advice before you see seek errors messages from the kernel or not.
> 
> It never advised me before seeing problems in the kernel (I had about 5 
> drives dying running Linux machines).

Were you actually monitoring the S.M.A.R.T. information before you suspected that the drive was failing, though?

S.M.A.R.T. data is only meaningful when it's monitored over a period of time.  The actual numbers are fairly meaningless, and are bound to vary from drive to drive, but if you suddenly find that, for example, spinning up the disk is taking longer than normal, then you might suspect that there is something wrong with the motor/spindle assembly.

S.M.A.R.T. is far from being perfect, but it is another tool that we have at our disposal.  All modern discs support S.M.A.R.T. so you might as well enable it.  If nothing else, you could replace the disk after, say, 10,000 power on hours, or 2500 spin up, (wash, rinse, spin), and spin down, cycles.  I.E. Preventative maintainance.

> It should be trivial to just grep the kernel log for the error and mail it 
> to some address. 

Exactly, you can do this in user space, using tail -f and a perl script.

> Another way to prove a dead drive is (after a backup) to drop it some 
> until it made a nice broken drive sound (a very high pitch shriek) and 
> bring it to the store that sold it to you (ideally a small one as they are 
> less technically challenged then big chains).

I think they would probably say that you voided the warranty.

John.
