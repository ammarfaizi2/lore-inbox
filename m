Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbTFFWta (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 18:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbTFFWta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 18:49:30 -0400
Received: from s1.uscreditbank.com ([192.41.74.10]:38407 "EHLO
	s1.uscreditbank.com") by vger.kernel.org with ESMTP id S262352AbTFFWt2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 18:49:28 -0400
Date: Fri, 6 Jun 2003 17:03:10 -0600
From: jmerkey@s1.uscreditbank.com
To: "Lauro, John" <jlauro@umflint.edu>
Cc: linux-kernel@vger.kernel.org, jmerkey@utah-nac.org
Subject: Re: 2.4.20 Modprobe setting of eth0,eth1 does not seem to work
Message-ID: <20030606170310.A20988@s1.uscreditbank.com>
References: <37885B2630DF0C4CA95EFB47B30985FB020EC0D2@exchange-1.umflint.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <37885B2630DF0C4CA95EFB47B30985FB020EC0D2@exchange-1.umflint.edu>; from jlauro@umflint.edu on Fri, Jun 06, 2003 at 06:04:41PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am using 4.6.11 from their website, which is the version needed to run the 
chipsets on the multi-port cards.  Is my modules.conf syntax correct?  I believe 
it is which eads me to believe the driver is busted.  I reviewed their probe
function and it looks correct.  

Any help is appreciated.

Jeff



On Fri, Jun 06, 2003 at 06:04:41PM -0400, Lauro, John wrote:
> I assume you mean between keyboard and chair???
> 
> Anyways...
> 
> If I do anything semi-advanced with e1000 cards, I end up getting
> Intel's drivers.  It's a minor pain when switching kernel versions
> (especially to a different version number) as the default scripts
> assume you are already booted (uname -r) in the kernel you are
> building for and are not part of the kernel source tree...
> 
> I suggest you try e1000-5.0.43 from Intel, and also iANS-2.3.35 (or
> higher if either of them have updates).
> 
> I don't know if you are doing any advanced features like vlan tagging
> or not.  Anyways, it's one area that drivers from Intel's site does
> work better then the native stock kernel drivers.  Specifically as an
> example, virtual Ethernets over different vlan tags when combined with
> vmware gsx server works with Intel's iANS, but not with the stock vlan
> support.
> 
> I know, it doesn't answer your question...  but it gives you something
> else to try...
> 
> > -----Original Message-----
> > From: jmerkey@s1.uscreditbank.com
> [mailto:jmerkey@s1.uscreditbank.com]
> > Sent: Friday, June 06, 2003 5:40 PM
> > To: linux-kernel@vger.kernel.org
> > Cc: jmerkey@utah-nac.org
> > Subject: 2.4.20 Modprobe setting of eth0,eth1 does not seem to work
> > 
> > 
> > 
> > In 2.4.20 if I attempt to use the Intel multiport e1000 drivers with
> > modules.conf trying to hard set the eth0,eth1, etc. assignments
> modprobe
> > does
> > not appear to be assigning the adapter aliases correctly.  I am
> assuming
> > this may be due to an interface issue between the Keyboard and
> monitor. :-
> > )
> > 
> > Modules.conf file attached.  Anyone got any ideas here?
> > 
> > Jeff
> > 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
