Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261709AbSJFQjJ>; Sun, 6 Oct 2002 12:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261716AbSJFQjJ>; Sun, 6 Oct 2002 12:39:09 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:51697 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261709AbSJFQjI>; Sun, 6 Oct 2002 12:39:08 -0400
Subject: Re: The end of embedded Linux?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: giduru@yahoo.com, Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021005.212832.102579077.davem@redhat.com>
References: <Pine.LNX.4.10.10210051252130.21833-100000@master.linux-ide.org>
	<20021005205238.47023.qmail@web13201.mail.yahoo.com> 
	<20021005.212832.102579077.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Oct 2002 17:53:26 +0100
Message-Id: <1033923206.21282.28.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-10-06 at 05:28, David S. Miller wrote:
> Embedded applications tend to have issues which are entirely specific
> to that embedded project.  As such, those are things that do not
> belong in a general purpose OS.

90% of the embedded Linux problem is not this. Its actually easy to get
most of the embedded needs into the base kernel - in fact they overlap
the other worlds a lot.

Need low power consumption/resource usage - thats S/390 mainframe
instances and ibm wristwatches.

Need good cpu control - thats desktop/laptop and embedded

Need good irq behaviour (pre-empt/low latency) - thats desktop/embedded

and it carries on like that.

No the big problem is that each embedded vendor is desperately trying to
keep their changes out of the mainstream so they can screw each other.
In doing so the main people they screw are all their customers.

So if the embedded people want 2.6 to be good at embedded they need to
get their heads out of their arses and contribute to the mainstream.
Otherwise they'll always be chasing a moving ball, and a ball most
people are kicking the other way down the field. Its a simple fact of
line, if you stick you head up your backside all you get to do is eat
shit

(and yes there are some embedded people who do contribute but they are
sadly a real minority)

Alan

