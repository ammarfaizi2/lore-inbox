Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbTL3JZs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 04:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265702AbTL3JZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 04:25:48 -0500
Received: from [62.116.46.196] ([62.116.46.196]:55821 "EHLO it-loops.com")
	by vger.kernel.org with ESMTP id S261744AbTL3JZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 04:25:47 -0500
Date: Tue, 30 Dec 2003 10:25:20 +0100
From: Michael Guntsche <mike@it-loops.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Network problems with b44 in 2.6.0
Message-Id: <20031230102520.173501ec.mike@it-loops.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did some more tests and found out that disabling ACPI support with
acpi=off gave me a functional card again.
pci=noacpi wasn't enough.

Someone knows how ACPI can interfere with the network in only one
direction (receive)?.
It would make more sense to me if the card didn't work at all.

Michael
