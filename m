Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753905AbWKGB3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905AbWKGB3M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 20:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753910AbWKGB3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 20:29:12 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:11948 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1753905AbWKGB3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 20:29:10 -0500
Subject: Re: Strange PCI behaviour on Via K8M800CE chipset Shuttle & sata
	fails with noapic
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Joseph Mathewson <joe@mathewson.co.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <454FD8B2.5070702@mathewson.co.uk>
References: <454FD8B2.5070702@mathewson.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 07 Nov 2006 01:32:26 +0000
Message-Id: <1162863146.11073.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-11-07 am 00:52 +0000, ysgrifennodd Joseph Mathewson:
> 2) Appear in lspci but not appear in /proc/interrupts.  Loading the 
> driver will result in no card found.  No interface.

In this case does lspci show different values particularly of device or
vendor id. If so you've got a dodgy PCI connector or link somewhere.


