Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266820AbUI0RMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266820AbUI0RMj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 13:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266813AbUI0RMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 13:12:38 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:9235 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266674AbUI0RMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 13:12:31 -0400
Date: Mon, 27 Sep 2004 18:12:29 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Antony Suter <suterant@users.sourceforge.net>
Cc: List LKML <linux-kernel@vger.kernel.org>, torvalds@osdl.org
Subject: Re: [PATCH] __VMALLOC_RESERVE export
Message-ID: <20040927181229.A25704@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Antony Suter <suterant@users.sourceforge.net>,
	List LKML <linux-kernel@vger.kernel.org>, torvalds@osdl.org
References: <1096304623.9430.8.camel@hikaru.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1096304623.9430.8.camel@hikaru.lan>; from suterant@users.sourceforge.net on Tue, Sep 28, 2004 at 03:03:43AM +1000
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2004 at 03:03:43AM +1000, Antony Suter wrote:
> __VMALLOC_RESERVE itself is not exported but is used by something that
> is. This patch is against 2.6.9-rc2-bk11
> 
> This is required by the nvidia binary driver 1.0.6111

And the driver does absolutely nasty things it shouldn't do.  This is an
implementation detail that absolutely should not be exported.

