Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263407AbTHJL4q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 07:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbTHJL4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 07:56:46 -0400
Received: from pizda.ninka.net ([216.101.162.242]:62637 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263407AbTHJL4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 07:56:45 -0400
Date: Sun, 10 Aug 2003 04:51:21 -0700
From: "David S. Miller" <davem@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: yoshfuji@linux-ipv6.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] convert drivers/scsi to virt_to_pageoff()
Message-Id: <20030810045121.31ef7ccc.davem@redhat.com>
In-Reply-To: <20030810123148.A10435@infradead.org>
References: <20030810013041.679ddc4c.davem@redhat.com>
	<20030810090556.GY31810@waste.org>
	<20030810020444.48cb740b.davem@redhat.com>
	<20030810.201009.77128484.yoshfuji@linux-ipv6.org>
	<20030810123148.A10435@infradead.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Aug 2003 12:31:48 +0100
Christoph Hellwig <hch@infradead.org> wrote:

> You probably want to use pci_map_single here instead..

I don't think it's wise to mix two changes at once.  Let's get
the straightforward "obvious" shorthand change in, then we can
add your enhancement.
