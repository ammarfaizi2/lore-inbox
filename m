Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263697AbUBRHo2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 02:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263793AbUBRHo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 02:44:28 -0500
Received: from s4.uklinux.net ([80.84.72.14]:61130 "EHLO mail2.uklinux.net")
	by vger.kernel.org with ESMTP id S263697AbUBRHoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 02:44:23 -0500
Date: Wed, 18 Feb 2004 07:44:14 +0000
To: linux-kernel@vger.kernel.org
Subject: pnp missing proc entries?
Message-ID: <20040218074414.GA11598@titan.home.hindley.uklinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Mark Hindley <mark@hindley.uklinux.net>
X-MailScanner-Titan: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have just switched to 2.6 and am trying to resolve and irq conflict
between a sound card and internal modem.

Looking in Documentation/pnp.txt there should be files in
proc/bus/isapnp/<node>/{id,resources,options}.

However all I have is plain node at /proc/bnus/isapnp/<node> that dumps
some binary data.

Is the documentation out of date? I can see the calls to make the
missing nodes in pnp_add_device() but can't find it called from
anywhere. Is this a deliberate omission?

Thanks

Mark

