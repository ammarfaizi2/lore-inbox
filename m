Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVDIB5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVDIB5r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 21:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVDIB5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 21:57:46 -0400
Received: from hcoop.net ([63.246.10.45]:59597 "EHLO Abulafia.hcoop.net")
	by vger.kernel.org with ESMTP id S261253AbVDIB5g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 21:57:36 -0400
Message-ID: <2183.130.76.32.15.1113011853.squirrel@130.76.32.15>
Date: Fri, 8 Apr 2005 18:57:33 -0700 (PDT)
Subject: Re: IDE CMD 64x PCI driver (BUG REPORT; CMD 648 DMA INITIALIZATION)
From: "Rob Gubler" <rob@gubler.net>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3-RC1
X-Mailer: SquirrelMail/1.4.3-RC1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quick follow up:  I decided to disable the DMA controller as a near term
solution.  This works but it is not optimal for obvious reasons.

I believe that the chipset initialization for utilizing the DMA controller
is incorrectly setup, for the particular model I am using (CMD 648).  I
don't know when/if I will look into this further.

For more information regarding my analysis of the problem refer to my
first email, with the email subject as "IDE CMD 64x PCI driver."

-Rob

