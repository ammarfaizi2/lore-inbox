Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbTJDETB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 00:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbTJDETB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 00:19:01 -0400
Received: from [66.212.224.118] ([66.212.224.118]:34314 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S261812AbTJDETA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 00:19:00 -0400
Date: Sat, 4 Oct 2003 00:18:53 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: James Cleverdon <jamesclv@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic irq_vector allocation for 2.6.0-test6-mm
In-Reply-To: <200310031807.20650.jamesclv@us.ibm.com>
Message-ID: <Pine.LNX.4.53.0310040016490.18935@montezuma.fsmlabs.com>
References: <200310031807.20650.jamesclv@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Oct 2003, James Cleverdon wrote:

> irq_vector is indexed by a value that can be as large as the sum of all the 
> RTEs in all the I/O APICs.  On a 32-way x445 or a 16-way x440 with PCI 
> expansion boxes, the static array will overflow.

What is number of interrupt sources on that 32x?
