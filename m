Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270997AbTHKF0r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 01:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270998AbTHKF0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 01:26:47 -0400
Received: from pizda.ninka.net ([216.101.162.242]:8371 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S270997AbTHKF0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 01:26:47 -0400
Date: Sun, 10 Aug 2003 22:21:00 -0700
From: "David S. Miller" <davem@redhat.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: hch@infradead.org, yoshfuji@linux-ipv6.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] convert drivers/scsi to virt_to_pageoff()
Message-Id: <20030810222100.1c4ed37a.davem@redhat.com>
In-Reply-To: <20030810145511.B32508@flint.arm.linux.org.uk>
References: <20030810013041.679ddc4c.davem@redhat.com>
	<20030810090556.GY31810@waste.org>
	<20030810020444.48cb740b.davem@redhat.com>
	<20030810.201009.77128484.yoshfuji@linux-ipv6.org>
	<20030810123148.A10435@infradead.org>
	<20030810145511.B32508@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Aug 2003 14:55:11 +0100
Russell King <rmk@arm.linux.org.uk> wrote:

> Actually, I'd rather see Scsi_Pointer gain page + offset (or even better
> a single sg element) and get rid of these conversions.

I think this is a great idea.
