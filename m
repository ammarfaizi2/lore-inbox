Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264002AbUG2DpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264002AbUG2DpR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 23:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264058AbUG2DpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 23:45:17 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:62736 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S264002AbUG2DpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 23:45:14 -0400
Date: Wed, 28 Jul 2004 20:45:01 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: net_device->irq vs pci_dev->irq
Message-ID: <20040728204500.A29711@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sent this to linux-net@ with no response today, anyone care to comment?

In the e1000-5.2.30.1 driver, "they" no longer propagate pdev->irq into
netdev->irq.  This looks safe to add back in, am I mistaken?  I want
ifconfig to report the irq, which it no longer does without netdev->irq.

This is on a 2.4 kernel (no MSI).

thx
/fc
