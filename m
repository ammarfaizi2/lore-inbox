Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318196AbSGQKcu>; Wed, 17 Jul 2002 06:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318210AbSGQKct>; Wed, 17 Jul 2002 06:32:49 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:57334 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318196AbSGQKct>; Wed, 17 Jul 2002 06:32:49 -0400
Subject: Re: [linux-lvm] Re: [Announce] device-mapper beta3 (fast snapshots)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: linux-lvm@sistina.com, Andrew Theurer <habanero@us.ibm.com>,
       Kevin Corry <corryk@us.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020717103112.GA595@fib011235813.fsnet.co.uk>
References: <3D2F6464.60908@us.ibm.com> <02071513565400.06209@boiler>
	<20020716084234.GA431@fib011235813.fsnet.co.uk>
	<200207161105.49328.habanero@us.ibm.com>
	<20020716163157.GA11334@fib011235813.fsnet.co.uk>
	<1026840444.21656.544.camel@tiny> 
	<20020717103112.GA595@fib011235813.fsnet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 17 Jul 2002 12:46:14 +0100
Message-Id: <1026906374.5709.136.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-17 at 11:31, Joe Thornber wrote:
> On Tue, Jul 16, 2002 at 01:27:24PM -0400, Chris Mason wrote:
> > Some IDE drives ignore commands to turn off the write back cache, or
> > turn it back on when load gets high.
> 
> I'm amazed hardware manufacturers would dare to do such a thing - I
> guess I'm naive.

Its not explicitly against the spec. Some of them also like to make
"cache flush" a no-op too. The next generation of ATA is supposed to add
explicit "direct to media" write command facilities

