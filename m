Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162222AbWKPCai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162222AbWKPCai (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162228AbWKPCai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:30:38 -0500
Received: from gate.crashing.org ([63.228.1.57]:48347 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1162222AbWKPCah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:30:37 -0500
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@osdl.org>,
       David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       tiwai@suse.de
In-Reply-To: <ada8xidz5zn.fsf@cisco.com>
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>
	 <20061114.190036.30187059.davem@davemloft.net>
	 <Pine.LNX.4.64.0611141909370.3349@woody.osdl.org>
	 <20061114.192117.112621278.davem@davemloft.net>
	 <Pine.LNX.4.64.0611141935390.3349@woody.osdl.org>
	 <455A938A.4060002@garzik.org>  <ada8xidz5zn.fsf@cisco.com>
Content-Type: text/plain
Date: Thu, 16 Nov 2006 13:29:30 +1100
Message-Id: <1163644170.5940.348.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-14 at 20:30 -0800, Roland Dreier wrote:
>  > That reminds me of a potential driver bug -- MSI-aware drivers need to
>  > call pci_intx(pdev,0) to turn off the legacy PCI interrupt, before
>  > enabling MSI interrupts.
> 
> Huh?  The device can't generate any legacy interrupts once MSI is
> enabled.  As the PCI spec says:

No, the device is _not_supposed_to_ :-)

Cheers,
Ben.

