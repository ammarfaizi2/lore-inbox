Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261870AbVAQPi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbVAQPi6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 10:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbVAQPi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 10:38:56 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:49283 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261826AbVAQPia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 10:38:30 -0500
Date: Mon, 17 Jan 2005 16:38:28 +0100
From: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: IDE PCI DMA
Message-Id: <20050117163828.545228e4.Christoph.Pleger@uni-dortmund.de>
Organization: Universitaet Dortmund
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-sun-solaris2.7)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I compiled a 2.4.28 kernel with modular IDE support. Running that kernel
on a machine and looking into /proc/ide/hda/settings shows that DMA is
not used for that disk, although I had chosen "use PCI DMA by default
when available". When a kernel with built-in IDE support is run, DMA for
hda is activated.

Why is it not activated in case of a module?

Kind regards
  Christoph
