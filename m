Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261958AbVCRRAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbVCRRAi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 12:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbVCRQ7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 11:59:09 -0500
Received: from host-212-158-219-180.bulldogdsl.com ([212.158.219.180]:39652
	"EHLO aeryn.fluff.org.uk") by vger.kernel.org with ESMTP
	id S261705AbVCRQ6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 11:58:37 -0500
Date: Fri, 18 Mar 2005 16:58:17 +0000
From: Ben Dooks <ben-linux@fluff.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] DM9000 network driver
Message-ID: <20050318165817.GA22545@home.fluff.org>
References: <20050318133143.GA20838@metis.extern.pengutronix.de> <1111162885.9874.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111162885.9874.13.camel@localhost.localdomain>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2005 at 04:21:30PM +0000, Alan Cox wrote:
> On Gwe, 2005-03-18 at 13:31, Sascha Hauer wrote:
> > Hello all,
> > 
> > This patch adds support for the davicom dm9000 network driver. The
> > dm9000 is found on some embedded arm boards such as the pimx1 or the
> > scb9328.
> 
> Unless I'm missing something its just yet another NE2000 (ie 8390) clone
> and can used the 8390 core or maybe even ne2k-pci  ?

Yes, you are missing something. The dm9000 is definetly
not an ne2k compatible, for a start it only uses two ports
(address and data), manages it's own transmit/receive queues, etc.

As the person who did the updates to Sacha's
original driver port, he should have really checked
with me for up-to-date version first, and to collect
a Signed-off-by: line.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
