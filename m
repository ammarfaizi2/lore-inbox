Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422979AbWAMVQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422979AbWAMVQG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 16:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422980AbWAMVQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 16:16:05 -0500
Received: from khc.piap.pl ([195.187.100.11]:63242 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1422979AbWAMVQE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 16:16:04 -0500
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: "Arne R. van der Heyde" <vanderHeydeAR@summitinstruments.com>,
       <linux-kernel@vger.kernel.org>, <c-d.hailfinger.kernel.2004@gmx.net>
Subject: Re: no carrier when using forcedeth on MSI K8N Neo4-F
References: <43C7F35A.9010703@summitinstruments.com>
	<Pine.LNX.4.61.0601131345260.8379@chaos.analogic.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Fri, 13 Jan 2006 22:16:01 +0100
In-Reply-To: <Pine.LNX.4.61.0601131345260.8379@chaos.analogic.com> (linux-os@analogic.com's message of "Fri, 13 Jan 2006 13:56:27 -0500")
Message-ID: <m3k6d3n81a.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"linux-os \(Dick Johnson\)" <linux-os@analogic.com> writes:

> You need to use the correct kind of cross-over cable for the Gigabit
> ports.

Correct, with all pairs crossed.
I don't force-death but I think most gigabit cards (and some 100BaseTX)
work with plain cable as well (using auto MDI-X, and auto-polarity
if needed).

> Then, you need to set both ports manually because there
> is no hardware (the switch) to handle the auto-configuration. The
> default is usually `autoneg on`. This tells the switch to
> auto-configure. Connected to another port, not a switch, this
> means nothing and the device remains dormant.

Again, I don't know nforce, but normal cards with autonegotiation
(i.e., (almost?) all 100BaseTX and newer) can negotiate speed and
duplex without need for a switch. BTW from net POI switches and
cards are DTEs, there is no special distinction WRT autonegotiation.
-- 
Krzysztof Halasa
