Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVAMUvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVAMUvI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 15:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVAMUux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 15:50:53 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:28389 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261383AbVAMUt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 15:49:29 -0500
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: brking@us.ibm.com, paulus@samba.org, benh@kernel.crashing.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050113202354.GA67143@muc.de>
References: <200501101449.j0AEnWYF020850@d03av01.boulder.ibm.com>
	 <m14qhpxo2j.fsf@muc.de> <41E2AC74.9090904@us.ibm.com>
	 <20050110162950.GB14039@muc.de> <41E3086D.90506@us.ibm.com>
	 <1105454259.15794.7.camel@localhost.localdomain>
	 <20050111173332.GA17077@muc.de>
	 <1105626399.4664.7.camel@localhost.localdomain>
	 <20050113180347.GB17600@muc.de>
	 <1105641991.4664.73.camel@localhost.localdomain>
	 <20050113202354.GA67143@muc.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105645491.4624.114.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 13 Jan 2005 19:44:52 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-01-13 at 20:23, Andi Kleen wrote:
> > X needs to be able to find the device layout in order to build its PCI
> > mappings. Cached data is probably quite sufficient for this.
> 
> I mean i would expect it to continue scanning other entries when it sees
> an error on one.  Is that not true?

X needs to be able to find the device layout in order to build its PCI
mappings. If there are things mysteriously vanishing now and then its
not going to have valid mappings

