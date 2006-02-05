Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWBEVy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWBEVy6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 16:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWBEVy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 16:54:58 -0500
Received: from fisica.ufpr.br ([200.17.209.129]:25224 "EHLO fisica.ufpr.br")
	by vger.kernel.org with ESMTP id S1750750AbWBEVy6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 16:54:58 -0500
To: linux-kernel@vger.kernel.org
Subject: nfsroot doesn't work with intel card since 2.6.12.2/2.6.11
Message-Id: <20060205215455.7622B1C8E46@fisica.ufpr.br>
Date: Sun,  5 Feb 2006 19:54:55 -0200 (BRST)
From: carlos@fisica.ufpr.br (Carlos Carvalho)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have several machines with Intel Corp. 82544EI Gigabit Ethernet
Controller (Copper) (rev 02), as reported by lspci. They don't manage
to mount the rootfs via nfs anymore. I've tried several combinations
and the last one that works is 2.6.12.2 using the 2.6.11 version of
the driver (simply replacing the files in the tree). 2.6.12.2 with its
own driver doesn't work.

There seems to be a pattern: at each version the machine has more
difficulty mounting the rootfs. Other machines using other ethercards
but with the same server and filesystem work normally.

This is a showstopper for us since we cannot upgrade the kernel.

The same problem happens with 2.4, and the last combination that
manages to boot is 2.4.32-pre1 with the 2.4.30 driver.

Any hints?
