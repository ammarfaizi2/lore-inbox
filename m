Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265091AbTFRNKQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 09:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265112AbTFRNKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 09:10:16 -0400
Received: from mail.ithnet.com ([217.64.64.8]:42763 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S265091AbTFRNKM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 09:10:12 -0400
Date: Wed, 18 Jun 2003 15:10:34 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "David S. Miller" <davem@redhat.com>
Cc: babydr@baby-dragons.com, linux-kernel@vger.kernel.org
Subject: Re: BUG: Massive performance drop in routing throughput with 2.4.21
 (62KB)
Message-Id: <20030618151034.0a84b2e2.skraw@ithnet.com>
In-Reply-To: <1055880260.19796.7.camel@rth.ninka.net>
References: <20030616141806.6a92f839.skraw@ithnet.com>
	<Pine.LNX.4.51.0306161444090.18129@dns.toxicfilms.tv>
	<20030616145135.0ef5c436.skraw@ithnet.com>
	<20030616151035.735fcaf2.martin.zwickel@technotrend.de>
	<Pine.LNX.4.56.0306161413360.3114@filesrv1.baby-dragons.com>
	<Pine.LNX.4.56.0306171518080.6807@filesrv1.baby-dragons.com>
	<1055880260.19796.7.camel@rth.ninka.net>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Jun 2003 13:04:20 -0700
"David S. Miller" <davem@redhat.com> wrote:

> On Tue, 2003-06-17 at 12:33, Mr. James W. Laferriere wrote:
> > 	Hello All ,  Here goes .  I made 'me too'ism in another thread
> > 	that may be related to what I am presenting here .  After my .sig
> > 	is what I hope to be enough pertitanent information to get the bug
> > 	stomped on .  This is driving me crazy .  Also if someone would
> > 	like to point me at a URL:/Method(s)/... to be able to acquire
> > 	further information that would make the effort for those that
> > 	really can code in the kernel jobs easier please do .
> > 	The slow down mentioned below happens with any network based
> > 	connection .  JimL
> 
> You can start by reporting the bug and all your debugging
> informtion to the correct list.
> 
> Networking developers DO NOT sit on linux-kernel, it's too high
> volume for them.  So use the correct list to report such
> problems.

Maybe I should have made it a bit clearer in my original post to this thread:
the thing is a show-stopper. You can watch a 2.4.21 box drop down its
throughput to somewhere around 2-4 kByte/sec on a 100 MBit/sec switched
network. You have to setup a real routing-environment testbed to notice the
problem. I did not see it using any of the rc's as a simple host with all kinds
of network applications (including high volume nfs), but not routing...

Regards,
Stephan


