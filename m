Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbVDEIFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbVDEIFK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 04:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVDEH7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 03:59:12 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:43484 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261602AbVDEHpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 03:45:53 -0400
Date: Tue, 5 Apr 2005 08:45:30 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm1
Message-ID: <20050405074530.GF26208@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050405000524.592fc125.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405000524.592fc125.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  bk-audit.patch

This introduces various AUDIT_ARCH numerical constants, which is a blatantly
stupid idea.  We already have a way to uniquely identify architectures, and
that's the ELF headers, no need for another parallel namespace.

(btw, could you please add to all patches who's responsible for them,
bk-audit.patch doesn't tell)
