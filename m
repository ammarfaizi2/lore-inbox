Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266892AbUJBQAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266892AbUJBQAs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 12:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266901AbUJBQAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 12:00:48 -0400
Received: from verein.lst.de ([213.95.11.210]:58019 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S266892AbUJBQAr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 12:00:47 -0400
Date: Sat, 2 Oct 2004 18:00:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: takata@linux-m32r.org
Cc: linux-kernel@vger.kernel.org
Subject: remaining m32r issues
Message-ID: <20041002160036.GA18784@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We're getting close to 2.6.9, aka the first release with official m32r
support.  So could you please remove the obsolete syscalls from the
default config so we don't have to support them forever?

Also there's still arch/m32r/drivers, and it adds new MOD_INC_USE_COUNT
users - but that one has been completely removed in -mm already
