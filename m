Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265226AbTFZAHu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 20:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265227AbTFZAHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 20:07:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30143 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265226AbTFZAHt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 20:07:49 -0400
Message-ID: <3EFA3C9B.8030301@pobox.com>
Date: Wed, 25 Jun 2003 20:21:47 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew Wilcox <willy@debian.org>
CC: Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] pci_name()
References: <20030625233525.GB451@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20030625233525.GB451@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> I'd kind of like to get rid of pci_dev->slot_name.  It's redundant with
> pci_dev->dev.bus_id, but that's one hell of a search and replace job.
> So let me propose pci_name(pci_dev) as a replacement.  That has the
> benefit of being shorter than either of the others and lets us do fun
> & interesting things later (maybe construct it on the fly for systems


and also it's nicely backwards compatible (source-wise), too.

	Jeff



