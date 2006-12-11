Return-Path: <linux-kernel-owner+w=401wt.eu-S937618AbWLKT1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937618AbWLKT1h (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 14:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937622AbWLKT1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 14:27:36 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:57515 "EHLO
	laptopd505.fenrus.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S937618AbWLKT1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 14:27:36 -0500
Subject: announce: irqbalance 0.55 released
From: Arjan van de Ven <arjan@linux.intel.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 11 Dec 2006 20:27:29 +0100
Message-Id: <1165865249.27217.419.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After a hiatus of 2 years, a new version of irqbalance is now released
at http://www.irqbalance.org .

irqbalance is the tool that maps/distributes the different interrupts in
your system to the various processors and cores that your computer may
have.

This new version knows about, and optimizes for, Dual and Quad core, and
knows about MSI, PCI-Express, NAPI, Cache domains, processor sockets etc
etc. In addition, the new irqbalance switches to a power-save mode when
there is little irq load on the system, trying to preserve power by
avoiding waking up processors more than needed.

A more detailed description of how the new algorithm works can be found
at http://www.irqbalance.org/documentation.php .

At this point only source packages are available, I hope that the linux
vendors will have packages for the various distributions ready in a few
days.

irqbalance is released under version 2 of the GNU General Public
License.

Greetings,
   Arjan van de Ven
