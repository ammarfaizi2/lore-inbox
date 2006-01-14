Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWANTUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWANTUs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 14:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbWANTUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 14:20:48 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:28091 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750830AbWANTUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 14:20:48 -0500
Subject: Re: [PATCH] Watchdog: Winsystems EPX-C3 SBC
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Calin A. Culianu" <calin@ajvar.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Willy Tarreau <willy@w.ods.org>
In-Reply-To: <Pine.LNX.4.64.0601132149430.9231@rtlab.med.cornell.edu>
References: <Pine.LNX.4.64.0601132149430.9231@rtlab.med.cornell.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 14 Jan 2006 19:24:09 +0000
Message-Id: <1137266649.23269.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some quick comments:

+       if (len) {
+               epx_c3_pet();
+       }

Doesn't need brackets (minor style)

Otherwise it looks excellent but should use request_region and friends
to claim the two ports it uses.

The see the "Sign your work:" bit of Documentation/SubmittingPatches are
it looks ready to go in.

Alan

