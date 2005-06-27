Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbVF0Tb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbVF0Tb1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 15:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbVF0Tb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 15:31:26 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:49311 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261733AbVF0Ta5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 15:30:57 -0400
Date: Mon, 27 Jun 2005 20:30:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>, reiser@namesys.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status
Message-ID: <20050627193051.GA22208@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, reiser@namesys.com,
	linux-kernel@vger.kernel.org
References: <20050620235458.5b437274.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050620235458.5b437274.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> reiser4

sparse isn't to happy about this:

hch@macfly:/work/linux-2.6.12$ make C=1 SUBDIRS=fs/reiser4/ >/dev/null 2>err.log && wc -l err.log
2286 err.log

The log is at http://verein.lst.de/~hch/linux-2.6.12-mm2-fs-reiser4-errors.log
