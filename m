Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262528AbVAJUfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262528AbVAJUfx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 15:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262518AbVAJUcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 15:32:43 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:25037 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262517AbVAJU3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 15:29:36 -0500
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: brking@us.ibm.com, paulus@samba.org, benh@kernel.crashing.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m14qhpxo2j.fsf@muc.de>
References: <200501101449.j0AEnWYF020850@d03av01.boulder.ibm.com>
	 <m14qhpxo2j.fsf@muc.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105382585.12028.96.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 10 Jan 2005 19:23:56 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-01-10 at 16:10, Andi Kleen wrote:
> brking@us.ibm.com writes:
> I think it would be better to do this check higher level in the driver.
> IMHO pci_*_config should stay lean and fast low level functions without
> such baggage. 

Userspace pci interfaces can also trigger this withour protection.


