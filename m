Return-Path: <linux-kernel-owner+w=401wt.eu-S932160AbXALBPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbXALBPA (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 20:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbXALBPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 20:15:00 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33374 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932160AbXALBO7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 20:14:59 -0500
Date: Fri, 12 Jan 2007 01:26:03 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: akpm@osdl.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libata: PIIX3 support
Message-ID: <20070112012603.35e291a9@localhost.localdomain>
In-Reply-To: <200701120108.l0C18CnN028291@harpo.it.uu.se>
References: <200701120108.l0C18CnN028291@harpo.it.uu.se>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2007 02:08:12 +0100 (MET)
Mikael Pettersson <mikpe@it.uu.se> wrote:

> On Wed, 10 Jan 2007 17:13:38 +0000, Alan <alan@lxorguk.ukuu.org.uk> wrote:
> >This I believe completes the PIIX range of support for libata
> >
> >This adds the table entries needed for the PIIX3, both a new PCI
> >identifier and a new mode list. It also fixes an erroneous access to PCI
> >configuration 0x48 on non UDMA capable chips.
> 
> Works fine here on a 430HX box (ASUS T2P4).
> I'm appending kernel messages for boots with the IDE driver and
> with the updated libata driver, in case you want to compare them.

Thanks a lot. That all looks good and fits the other test reports nicely
(except qemu which appears to have PIIX3 emulation issues which Tejun's
quite fussy and careful eh code picks up on)

Alan
