Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264992AbUFVQMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264992AbUFVQMv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 12:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264916AbUFVQMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 12:12:20 -0400
Received: from gate.crashing.org ([63.228.1.57]:18600 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265027AbUFVQL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 12:11:57 -0400
Subject: Re: sungem - ifconfig eth0 mtu 1300 -> oops
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       "David S. Miller" <davem@redhat.com>,
       Herbert Xu <herbert@gondor.apana.org.au>, kernel@nn7.de,
       Linux Kernel list <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
In-Reply-To: <40D84A9B.8010503@pobox.com>
References: <20040621141144.119be627.davem@redhat.com>
	 <40D847E3.2080109@nortelnetworks.com>  <40D84A9B.8010503@pobox.com>
Content-Type: text/plain
Message-Id: <1087920212.22687.50.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 22 Jun 2004 11:03:34 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-22 at 10:04, Jeff Garzik wrote:
> Chris Friesen wrote:
> > Just a quick question.  Does the sungem chip support jumbo frames?  I'd 
> > like to use MTU of 9000 to make large local transfers more efficient, 
> > but it didn't seem to work last time I checked.
> 
> 
> Are you 100% certain you configured the other side to support jumbo?
> 
> Jumbo frames are non-standard, and sometimes require configuring MTU on 
> the switch or remote network card (if directly connected).

Well, it's not enabled in the driver I think, or at least it wasn't last
time I looked. Dave told me the chip fifo's are too small to do anything
useful with jumbo frames.

Ben.


