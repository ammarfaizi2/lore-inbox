Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267473AbUG2RWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267473AbUG2RWf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 13:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264853AbUG2RWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 13:22:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12991 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267474AbUG2RVV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 13:21:21 -0400
Message-ID: <41093200.1010004@pobox.com>
Date: Thu, 29 Jul 2004 13:21:04 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Frank Cusack <fcusack@fcusack.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: net_device->irq vs pci_dev->irq
References: <20040728204500.A29711@google.com>
In-Reply-To: <20040728204500.A29711@google.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Cusack wrote:
> Sent this to linux-net@ with no response today, anyone care to comment?

netdev@oss.sgi.com is the best place for network stack/driver development.


> In the e1000-5.2.30.1 driver, "they" no longer propagate pdev->irq into
> netdev->irq.  This looks safe to add back in, am I mistaken?  I want
> ifconfig to report the irq, which it no longer does without netdev->irq.

netdev->irq is purely informational.  Setting, or not, is largely 
irrelevant these days.

	Jeff


