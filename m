Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbTICG5k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 02:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbTICG5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 02:57:40 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:1664 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261336AbTICG5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 02:57:39 -0400
Date: Wed, 3 Sep 2003 08:10:33 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200309030710.h837AXnR000500@81-2-122-30.bradfords.org.uk>
To: linux-kernel@vger.kernel.org, lm@bitmover.com
Subject: Re: Scaling noise
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Tell me again that it is a good idea to screw up uniprocessor performance
> for 64 way machines.  Great idea, that.  Go Dinosaurs!

I suspect Larry is actually right that uniprocessor and $smallnum CPUs
SMP performance will remain the most important, but I don't agree with
his reasoning:

Once true virtualisation becomes part of a mainstream microprocessor
architecture, we'll start to see a lot of small ISPs wanting to move 4
or so 1U servers on to a single, 1U SMP box.  Server consolidation
saves money in many ways - physical LAN cabling is replaced by virtual
LANs, less network hardware such as switches is required, there is
less hardware to break, you can add a new Linux image in seconds using
spare capacity rather than going out and buying a new box.

Once the option of running a firewall, a hot spare firewall, a
customer webserver, a hot spare customer webserver, mail server,
backup mail server, and a few virtual machines for customers, all on a
1U box, why are you going to want to pay for seven or more Us in a
datacentre, plus extra network hardware?

You can do this today on Z/Series, but you need to consolidate a lot
of machines to make it financially viable.  Once virtualisation is
available on cheaper hardware, everybody will want $bignum way SMP
boxes, but no Linux image will run on more than $smallnum virtual
CPUs.

John.
