Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262977AbTDVHrZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 03:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262982AbTDVHrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 03:47:25 -0400
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:27891 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262977AbTDVHrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 03:47:24 -0400
Date: Tue, 22 Apr 2003 09:59:22 +0200
From: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: ARP
Message-Id: <20030422095922.6938d362.Christoph.Pleger@uni-dortmund.de>
In-Reply-To: <Pine.LNX.4.44.0304171308000.6853-100000@sparrow>
References: <20030417185540.28c74d42.Christoph.Pleger@uni-dortmund.de>
	<Pine.LNX.4.44.0304171308000.6853-100000@sparrow>
Organization: Universitaet Dortmund
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; sparc-sun-solaris2.6)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello William,

> Good afternoon, Chris,
> 
> On Thu, 17 Apr 2003, Christoph Pleger wrote:
> 
> > I want to use FreeS/WAN with kernel 2.4. For the configuration I
> > have to reach with FreeS/WAN I need the ability to tell a host that
> > it shall accept traffic which is directed to another host. I tried
> > doing that by the user space program arp, but it did not work and
> > after that I read in the manual page of arp that since kernel
> > version 2.2.0 setting an arp entry for a whole subnet is no longer
> > supported. 
> > 
> > Is there something else I can do to tell the hosts in a subnet to
> > send packets for a specific not to that host itself but to another
> > host? This should be done transparently so that the hosts do not
> > know that their ip packets do not go directly to the destination.
> 
> 	Proxy arp _does_ work, to the est of my knowledge, still.  You
> 	may 
> need to put in the entries for each workstation, that that's a simple 
> shell loop in your network startup.
> 
> http://www.stearns.org/doc/proxyarp-howto

I did exactly what you described on your webpage (of course I changed
the addresses), but the arp request of another host still is not
answered by the FreeS/WAN gateway. Do I have to enable special kernel
options for proxy arp to work?

Kind regards
  Christoph
