Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263519AbTDDRos (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 12:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263509AbTDDRoI (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 12:44:08 -0500
Received: from ip67-93-141-189.z141-93-67.customer.algx.net ([67.93.141.189]:40690
	"EHLO datapower.ducksong.com") by vger.kernel.org with ESMTP
	id S263850AbTDDQvA (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 11:51:00 -0500
Date: Fri, 4 Apr 2003 12:02:14 -0500
From: "Patrick R. McManus" <mcmanus@ducksong.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Justin Cormack <justin@street-vision.com>, Paul Rolland <rol@as2917.net>,
       "'Michael Knigge'" <Michael.Knigge@set-software.de>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Strange e1000
Message-ID: <20030404170214.GA1457@ducksong.com>
References: <043501c2faaf$da061e10$3f00a8c0@witbe> <1049467531.2676.87.camel@lotte> <20030404154842.GA10607@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030404154842.GA10607@gtf.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Jeff Garzik: Apr 04 10:48]
> On Fri, Apr 04, 2003 at 03:45:25PM +0100, Justin Cormack wrote:
> > On Fri, 2003-04-04 at 14:41, Paul Rolland wrote:
> > > Hello,
> > > 
> > > > when I load the e1000 module, my NIC is recognized. Then, "pump -i 
> > > > eth0" is called (DHCP-Client), the message "e1000: eth0 NIC 
> > > > Link is Up 
> > > > 1000 Mbps Full Duplex" appears and after some time I get the message 
> > > > "operation failed".
> > > > 
> > > > When I sleep some time (currently 20 seconds) before doing 
> > > > the "pump", 
> > > > everything works as expected.
> > > > 
[..]

> > It is probably something like this. For some reason the managed Netgear
> > switches take a very long time to do anything. Log into the switch and
> > watch the port status while this happens to confirm. I actually can't
> > netboot off these switches because if this. Hopefully Netgear will come
> > up with a fix.
> 
> In another thread, Scott Feldman (one of the e1000 team) asked if
> spanning trees were enabled on the switch.  That could be a potential
> cause.

I can confirm this is isolated to the managed netgear switches.. I
started the other thread jeff mentions and, just this morning, cobbled
together a network without them and had no problems. I'll see if I can
create a setup without spanning tree to test that explicitly.
