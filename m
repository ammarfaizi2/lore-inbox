Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162210AbWKPCZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162210AbWKPCZY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162216AbWKPCZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:25:24 -0500
Received: from gate.crashing.org ([63.228.1.57]:4748 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1162210AbWKPCZX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:25:23 -0500
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
Cc: jeff@garzik.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       tiwai@suse.de
In-Reply-To: <20061114.201549.69019823.davem@davemloft.net>
References: <20061114.192117.112621278.davem@davemloft.net>
	 <Pine.LNX.4.64.0611141935390.3349@woody.osdl.org>
	 <455A938A.4060002@garzik.org>
	 <20061114.201549.69019823.davem@davemloft.net>
Content-Type: text/plain
Date: Thu, 16 Nov 2006 13:24:19 +1100
Message-Id: <1163643859.5940.340.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Is this absolutely true?  I've never been sure about this point, and I
> was rather convinced after reading various documents that once you
> program up the MSI registers to start generating MSI this implicitly
> disabled INTX and this was even in the PCI specification.

I think it is in the spec, that doesn't mean all device vendors get it
right. I have a vendor spec under my eyes at the moment (sorry, can't
say what it is) which has exactly this bug.

Ben.


