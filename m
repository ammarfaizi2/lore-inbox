Return-Path: <linux-kernel-owner+w=401wt.eu-S1161285AbXAHNaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161285AbXAHNaj (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 08:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161286AbXAHNaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 08:30:39 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39208 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161285AbXAHNai (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 08:30:38 -0500
Date: Mon, 8 Jan 2007 13:30:36 +0000
From: Christoph Hellwig <hch@infradead.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: kallsyms_lookup export in -mm
Message-ID: <20070108133036.GA18681@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This beast definitly shouldn't be exported.  drivers/mtd/ubi/debug.c
should probably be just removed instead - it's an utter mess anyway.
