Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030549AbWBAGkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030549AbWBAGkj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 01:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030550AbWBAGkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 01:40:39 -0500
Received: from [85.8.13.51] ([85.8.13.51]:53733 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1030549AbWBAGki (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 01:40:38 -0500
Message-ID: <43E057DA.7000909@drzeus.cx>
Date: Wed, 01 Feb 2006 07:40:26 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060119)
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Purpose of MMC_DATA_MULTI?
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that a new transfer flag was recently added to the MMC layer
without any immediate users, the MMC_DATA_MULTI flag. I'm guessing the
purpose of the flag is to indicate the difference between
MMC_READ_SINGLE_BLOCK and MMC_READ_MULTIPLE_BLOCKS with just one block.
If so, then that should probably be mentioned in a comment somewhere.

Rgds
Pierre
