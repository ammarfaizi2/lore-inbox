Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263467AbTJLMGI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 08:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263469AbTJLMGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 08:06:08 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:35726 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263467AbTJLMGG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 08:06:06 -0400
Date: Sun, 12 Oct 2003 13:06:05 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Peter Matthias <espi@epost.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ACM USB modem on Kernel 2.6.0-test
Message-ID: <20031012120605.GD13427@mail.shareable.org>
References: <FwYB.Z9.25@gated-at.bofh.it> <q14bmb.j9.ln@127.0.0.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <q14bmb.j9.ln@127.0.0.1>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Matthias wrote:
> Sound good, but I don't have /sys/ (nor do I have /proc/sys/bus/) with the
> OHCI driver.

You're using 2.6.0-test7, so you have sysfs in the kernel.
Do this:

	mkdir /sys
	mount none /sys -t sysfs

-- Jamie
