Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262125AbVATL6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbVATL6Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 06:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbVATL6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 06:58:16 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:61866 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262125AbVATL6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 06:58:14 -0500
Date: Thu, 20 Jan 2005 11:58:13 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1-mm2
Message-ID: <20050120115813.GA718@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050119213818.55b14bb0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050119213818.55b14bb0.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +uml-provide-a-release-method-for-the-ubd-driver.patch

This one is bogus.  The driver core doesn't warn about a missing
release method just so that we add an empty one and bloat the kernel.

The object's lifetime rules needs fixing instead, and until that
happens that warning should be kept.

