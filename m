Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267417AbSLLFKu>; Thu, 12 Dec 2002 00:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267419AbSLLFKu>; Thu, 12 Dec 2002 00:10:50 -0500
Received: from dsl-64-34-35-93.telocity.com ([64.34.35.93]:21009 "EHLO
	roo.rogueind.com") by vger.kernel.org with ESMTP id <S267417AbSLLFKt>;
	Thu, 12 Dec 2002 00:10:49 -0500
Date: Thu, 12 Dec 2002 00:18:35 -0500 (EST)
From: Tom Diehl <tdiehl@rogueind.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Karina <kgs@acabtu.com.mx>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Trouble with kernel 2.4.18-18.7.x
In-Reply-To: <1039553498.14302.58.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0212120002230.9232-100000@tigger.rogueind.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Dec 2002, Alan Cox wrote:

> On Tue, 2002-12-10 at 19:33, Karina wrote:
> > Hi, i've just installed kernel 2.4.18-18.7.x  (from RPM) and now it
> > seems there are problems with my scsi devices.
> > I have attached an adaptec scsi  AIC7XXX adapter, the system detects the
> > device, but in the logs appears messages: "blk: queue c24afa18, I/0
> > limit 4095Mb (mask0xfffffff)", these messages didn't appear before with
> > my old kernel.
> 
> Thats a perfectly normal message. Its giving parameters for your scsi
> 
> > Also, there are another messages in the dmesg results:
> > 
> > kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter errno = 2
> 
> That one is a bit stranger. I'd have expected it to put the scsi adapter
> in the initrd which apparently it hasnt

I get the exact same message on an intel L440GX (VA Linux) machine. I 
attributed it to the routing problem this board has. Looks like I was 
wrong or was I? FWIW I do not have any SCSI devices attached.

> So it looks like its ok. Do file the kmod: failed to exec report in
> https://bugzilla.redhat.com/bugzilla however. Regardless of it not being
> a problem in your case it does want fixing

Assuming that you still want it in bugzilla if Karina does not do it I will.
Karina if you do bugzilla this please let me know the number.

Enjoy,

-- 
.............Tom	"Nothing would please me more than being able to 
tdiehl@rogueind.com	hire ten programmers and deluge the hobby market 
			with good software." -- Bill Gates 1976

   			We are still waiting ....

