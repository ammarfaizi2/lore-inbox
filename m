Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263142AbTI3GZX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 02:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbTI3GZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 02:25:23 -0400
Received: from rth.ninka.net ([216.101.162.244]:39553 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263144AbTI3GZW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 02:25:22 -0400
Date: Mon, 29 Sep 2003 23:25:20 -0700
From: "David S. Miller" <davem@redhat.com>
To: Xose Vazquez Perez <xose@wanadoo.es>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] pci.ids for e1000
Message-Id: <20030929232520.0184a8f7.davem@redhat.com>
In-Reply-To: <3F621965.4070106@wanadoo.es>
References: <3F621965.4070106@wanadoo.es>
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Sep 2003 21:07:17 +0200
Xose Vazquez Perez <xose@wanadoo.es> wrote:

> Linus and Marcelo should not accept patches against pci.ids,
> all updates should go to pciids.sf.net. And every X time
> to do a sync with 2.4 and 2.6.

I don't know if this is the best idea.

When merging in a driver, it makes perfect sense to add the
appropriate device IDs to all PCI ID files.

On the other hand this could make life difficult for the
pciids.sf.net person.
