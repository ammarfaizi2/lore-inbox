Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262941AbUC2NSD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 08:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262961AbUC2NSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 08:18:00 -0500
Received: from verein.lst.de ([212.34.189.10]:38877 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262941AbUC2NPo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 08:15:44 -0500
Date: Mon, 29 Mar 2004 15:15:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: CAN-2003-0018 vs 2.6?
Message-ID: <20040329131536.GA6296@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CAN-2003-0018 (Linux O_DIRECT Direct Input/Output Information Leak
Vulnerability) is still not fixed in mainline 2.6.

Last time I pinged you you said you didn't like the fixes but we're
getting to the point where 2.6 gets seriously used and we should start
to care.  In fact SuSE has been adding the patches to their tree now
which means an direct I/O API change which is kinda messy to maintain
for XFS (which isn't even affected by the vulnerability due to it's own
locking) that's supposed to supply vendors with uptodas.

So any plans to gets this in?
