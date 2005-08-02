Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbVHBObs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVHBObs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 10:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVHBO3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 10:29:11 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:26276 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S261546AbVHBO1a convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 10:27:30 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: powerbook power-off and 2.6.13-rc[3,4]
Date: Tue, 2 Aug 2005 16:32:44 +0200
User-Agent: KMail/1.8.1
Cc: Stelian Pop <stelian@popies.net>,
       Johannes Berg <johannes@sipsolutions.net>,
       "Antonio-M. Corbi Bellot" <antonio.corbi@ua.es>,
       debian-powerpc@lists.debian.org
References: <1122904460.6491.41.camel@localhost.localdomain> <1122905228.6881.9.camel@localhost> <1122907136.31350.45.camel@localhost.localdomain>
In-Reply-To: <1122907136.31350.45.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200508021632.45344.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 1 of August 2005 16:38, Stelian Pop wrote:
> Le lundi 01 août 2005 à 16:07 +0200, Johannes Berg a écrit :
> > On Mon, 2005-08-01 at 15:54 +0200, Antonio-M. Corbi Bellot wrote:
> > 
> > > Has anyone observed this behaviour (O.S. halt ok but _no_ power-off at
> > > the end) with these new '-rc' kernels?
> > 
> > Yes. I haven't looked for the cause yet though.

I have observed this too, but only on an SMP (dual-core) machine,
using 2.6.13-rc4 or 2.6.13-rc4-mm1.

If the USB controller drivers (ohci_hcd, ehci_hcd) are not loaded, the
machine is powered off normally.  Otherwise, it is not.

Greets,
Rafael
 

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
