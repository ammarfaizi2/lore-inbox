Return-Path: <linux-kernel-owner+w=401wt.eu-S1754832AbXABNkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754832AbXABNkr (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 08:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754836AbXABNkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 08:40:47 -0500
Received: from khepri.openbios.org ([80.190.231.112]:50978 "EHLO
	khepri.openbios.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754832AbXABNkq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 08:40:46 -0500
X-Greylist: delayed 1108 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jan 2007 08:40:46 EST
Date: Tue, 2 Jan 2007 14:22:12 +0100
From: Stefan Reinauer <stepan@coresystems.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, jengelh@linux01.gwdg.de,
       David Miller <davem@davemloft.net>, devel@laptop.org
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
Message-ID: <20070102132212.GA10522@coresystems.de>
References: <459714A6.4000406@firmworks.com> <Pine.LNX.4.61.0612311350060.32449@yvahk01.tjqt.qr> <20061231.124531.125895122.davem@davemloft.net> <1167709406.6165.6.camel@localhost.localdomain> <b8370fecbb4a917934b0b163ea5774f5@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8370fecbb4a917934b0b163ea5774f5@kernel.crashing.org>
X-Operating-System: Linux 2.6.18.2-4-default on an x86_64
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Duff: Orig. Duff, Duff Lite, Duff Dry, Duff Dark,
	Raspberry Duff, Lady Duff, Red Duff, Tartar Control Duff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Segher Boessenkool <segher@kernel.crashing.org> [070102 12:37]:
> Are you really suggesting that using a kernel copy of the
> device tree is the correct thing to do, and the only correct
> thing to do -- with the sole argument that "that's what the
> current ports do"?

There might also be a speed advantage if any drivers or user space
programs operate heavily on the device tree on those systems with _lots_
of devices.. 

Stefan 

-- 
coresystems GmbH • Brahmsstr. 16 • D-79104 Freiburg i. Br.
      Tel.: +49 761 7668825 • Fax: +49 761 7664613
Email: info@coresystems.de  • http://www.coresystems.de/
