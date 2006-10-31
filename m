Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161609AbWJaELa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161609AbWJaELa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 23:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161620AbWJaELa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 23:11:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21442 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161609AbWJaEL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 23:11:29 -0500
Date: Mon, 30 Oct 2006 20:11:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: andrew.j.wade@gmail.com
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Greg KH <greg@kroah.com>, Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [2.6.19-rc3-mm1] BUG at arch/i386/mm/pageattr.c:165
Message-Id: <20061030201123.5685529f.akpm@osdl.org>
In-Reply-To: <200610302258.31613.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
References: <20061029160002.29bb2ea1.akpm@osdl.org>
	<200610302203.37570.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
	<20061030191340.1c7f8620.akpm@osdl.org>
	<200610302258.31613.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2006 22:58:11 -0500
Andrew James Wade <andrew.j.wade@gmail.com> wrote:

> I've just found out that unsetting CONFIG_SYSFS_DEPRECATED makes the
> crash go away.

How bizarre.  sysfs changes cause unexpected pte protection values?

> I can hack around the resulting udev incompatibility.

ok..
