Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbTDQOzi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 10:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbTDQOzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 10:55:38 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:10880 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261501AbTDQOzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 10:55:37 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304171509.h3HF9PS1000278@81-2-122-30.bradfords.org.uk>
Subject: Re: Subtle semantic issue with sleep callbacks in drivers
To: jgarzik@pobox.com (Jeff Garzik)
Date: Thu, 17 Apr 2003 16:09:25 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), mochel@osdl.org (Patrick Mochel),
       andrew.grover@intel.com (Grover Andrew),
       benh@kernel.crashing.org (Benjamin Herrenschmidt),
       linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <20030417144844.GC18749@gtf.org> from "Jeff Garzik" at Apr 17, 2003 10:48:44 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The video BIOS on a card often contains information that is found
> -nowhere- else.  Not in the chip docs.  Not in a device driver.
> Such information can and does vary from board-to-board, such as RAM
> timings, while the chip remains unchanged.

Incidently, what happens if we:

* Suspend
* Swap VGA card with another one
* Restore

!?

John.
