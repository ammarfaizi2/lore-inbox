Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752323AbWCPQBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323AbWCPQBd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 11:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752316AbWCPQBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 11:01:33 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:34180 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751998AbWCPQBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 11:01:33 -0500
Date: Thu, 16 Mar 2006 16:01:30 +0000
From: Christoph Hellwig <hch@infradead.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, aia21@cantab.net, len.brown@intel.com
Subject: Re: [patch 1/1] consolidate TRUE and FALSE
Message-ID: <20060316160129.GB6407@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, aia21@cantab.net, len.brown@intel.com
References: <200603161004.k2GA46Fc029649@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603161004.k2GA46Fc029649@shell0.pdx.osdl.net>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The patch implements TRUE and FALSE in include/linux/kernel.h and removes all
> the private versions.
> 
> The patch also kills off a few private implementations of NULL.

NACK.  Just kill them all and use 0/1

