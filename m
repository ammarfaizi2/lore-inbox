Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264026AbTFHWlj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 18:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264037AbTFHWli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 18:41:38 -0400
Received: from main.gmane.org ([80.91.224.249]:59848 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264026AbTFHWlh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 18:41:37 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Pasi Savolainen <psavo@iki.fi>
Subject: Re: 2.5.70-mm6
Date: Sun, 8 Jun 2003 22:52:37 +0000 (UTC)
Message-ID: <bc0enl$9cf$1@main.gmane.org>
References: <20030607151440.6982d8c6.akpm@digeo.com>
X-Complaints-To: usenet@main.gmane.org
User-Agent: slrn/0.9.7.4 (Linux)
Cc: linux-mm@kvack.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@digeo.com>:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.70/2.5.70-mm6/

Xfree86 4.3.0 won't start on this one. -mm4 started fine.
X will stop (and seemingly hang) on PCI initialization and iteration stage.

> linus.patch

I'd say this is the source of this. Some cleanup along pci_for_each_dev
removal. All the 'fixes' (into while) don't even compile warningless.


-- 
   Psi -- <http://www.iki.fi/pasi.savolainen>

