Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbVGFWQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbVGFWQn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 18:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbVGFWQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 18:16:21 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:16005 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262524AbVGFWPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 18:15:03 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: Linux 2.6.13-rc2: PCMCIA problem on AMD64
Date: Thu, 7 Jul 2005 00:15:19 +0200
User-Agent: KMail/1.8.1
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0507052126190.3570@g5.osdl.org> <200507061128.49843.rjw@sisk.pl> <20050707014348.A1005@jurassic.park.msu.ru>
In-Reply-To: <20050707014348.A1005@jurassic.park.msu.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507070015.20373.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 6 of July 2005 23:43, Ivan Kokshaysky wrote:
> On Wed, Jul 06, 2005 at 11:28:49AM +0200, Rafael J. Wysocki wrote:
> > albercik:~ # cardmgr
> > cardmgr[4702]: no sockets found!
> ..
> > PCI: Device 0000:02:01.0 not available because of resource collisions
> > PCI: Device 0000:02:01.1 not available because of resource collisions
> 
> Thanks for the report.
> Does the appended one-liner fix that?

Yes, it does, but I'm still getting these in dmesg:

PCI: Failed to allocate mem resource #10:2000000@100000000 for 0000:02:01.0
PCI: Failed to allocate mem resource #10:2000000@100000000 for 0000:02:01.1
PCI: Failed to allocate I/O resource #7:1000@e000 for 0000:02:01.1
PCI: Failed to allocate I/O resource #8:1000@e000 for 0000:02:01.1

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
