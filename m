Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbULGDYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbULGDYq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 22:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbULGDYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 22:24:46 -0500
Received: from quickstop.soohrt.org ([81.2.155.147]:33480 "EHLO
	quickstop.soohrt.org") by vger.kernel.org with ESMTP
	id S261750AbULGDYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 22:24:43 -0500
Date: Tue, 7 Dec 2004 04:24:38 +0100
From: Karsten Desler <kdesler@soohrt.org>
To: jamal <hadi@cyberus.ca>
Cc: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       "David S. Miller" <davem@davemloft.net>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: _High_ CPU usage while routing (mostly) small UDP packets
Message-ID: <20041207032438.GA7767@soohrt.org>
References: <20041206224107.GA8529@soohrt.org> <E1CbSf8-00047p-00@calista.eckenfels.6bone.ka-ip.net> <20041207002012.GB30674@quickstop.soohrt.org> <1102387595.1088.48.camel@jzny.localdomain> <20041207025456.GA525@soohrt.org> <1102389533.1089.51.camel@jzny.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1102389533.1089.51.camel@jzny.localdomain>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* jamal wrote:
> > The only thing I can think off is the 66/64 PCI bus and the
> > disadvantageous placement of the PCI cards, but neither should cause a
> > higher CPU usage. If the bus couldn't keep up, I'd get packetloss.
> > 
> 
> cant tell offhand; it looks like a modern piece of hardware.
> Are you sure you are using NAPI? This is an e1000, correct?
> 

Yes and yes.

0000:01:01.0 Ethernet controller: Intel Corp. 82545EM Gigabit Ethernet Controller (Fiber) (rev 01)
0000:01:03.0 Ethernet controller: Intel Corp. 82546GB Gigabit Ethernet Controller (rev 03)

driver: e1000
version: 5.5.4-k2-NAPI
firmware-version: N/A
bus-info: 0000:01:03.0

driver: e1000
version: 5.5.4-k2-NAPI
firmware-version: N/A
bus-info: 0000:01:01.0
