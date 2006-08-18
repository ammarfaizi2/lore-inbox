Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751510AbWHRWHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbWHRWHG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 18:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbWHRWHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 18:07:06 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:52879 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751510AbWHRWHE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 18:07:04 -0400
Date: Fri, 18 Aug 2006 17:07:00 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, akpm@osdl.org, Arnd Bergmann <arnd@arndb.de>,
       James K Lewis <jklewis@us.ibm.com>, Utz Bacher <utz.bacher@de.ibm.com>,
       ens Osterkamp <Jens.Osterkamp@de.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 0/6]:  powerpc/cell spidernet ethernet driver update
Message-ID: <20060818220700.GG26889@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff,

Can you apply and forward upstream the following series of patches?
This is the same set of patches I sent only a few days ago; however,
it appears that I failed to cc you on some of them, and I failed to
ask anyone in particular to actually apply them. So I'm asking now. :-)

The maintainership of the spidernet driver is transitioning from
Utz Bacher and Jens Osterkamp to Jim Lewis; you should be receiving
a patch to the MAINTAINERS file from Jim, noting this, shortly.  
I suspect that neither Utz nor Jens will be ack'ing or nack'ing 
these patches unless prodded; let me know if you want some particlar
ack from someone before you apply these. (BenH and Arnd Bergmann
are the ones who usually keep us honest about these things.)

Although these are based on a week-old mm tree, they should 
apply cleanly just about anywhere, as there has been little/no 
change to this code base in a long while. 

The patches bring the transmit performance of the driver up
to a decent level, as reviewed in greter detail in the patch
descriptions.

--linas
