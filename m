Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbWBURmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWBURmV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 12:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWBURmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 12:42:21 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41633 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932237AbWBURmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 12:42:20 -0500
Date: Tue, 21 Feb 2006 17:42:16 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Mike D. Day" <ncmike@us.ibm.com>
Cc: xen-devel@lists.xensource.com, lkml <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [ PATCH 2.6.16-rc3-xen 1/3] sysfs: export Xen hypervisor attributes to sysfs
Message-ID: <20060221174216.GA26784@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Mike D. Day" <ncmike@us.ibm.com>, xen-devel@lists.xensource.com,
	lkml <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
	Dave Hansen <haveblue@us.ibm.com>
References: <43FB2573.3070909@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FB2573.3070909@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Patch 1 (this patch) is a Xen file that is used by all OS kernels that run
> on Xen. This includes linux, NetBSD, FreeBSD, Solaris, and others. Patch 1
> adds #defined constants so that linux users of this file can avoid 
> typedefs. 

No way we're gonna put in that crap.  If you want linux to support Xen
add a set of sane linux-style headers for linux use.  What you use 
in the hypevisor or for other operating systems doesn't matter at all.
