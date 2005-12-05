Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbVLEOQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbVLEOQP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 09:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbVLEOQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 09:16:15 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:25497 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S1751355AbVLEOQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 09:16:15 -0500
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 No Idle HZ aka dynticks v051205
In-Reply-To: <200512051154.45500.kernel@kolivas.org>
References: <200512051154.45500.kernel@kolivas.org>
Date: Mon, 5 Dec 2005 14:16:14 +0000
Message-Id: <E1EjH8Y-0001Pz-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:

> If you get strange stalls with this patch then almost certainly it is a
> problem with dynticks and your apic so booting with the "noapic" option
> should fix it.

I get strange stalls even with "noapic". During boot, the system keeps
pausing unless I do something that generates interrupts (holding down
the enter key works). dyntick=disable lets the machine boot normally. Is
there anything handy I can do to help debug this?
-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
