Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbVBRSmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbVBRSmb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 13:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVBRSmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 13:42:31 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37034 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261433AbVBRSmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 13:42:16 -0500
Date: Fri, 18 Feb 2005 18:42:03 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.10 patch to export kallsyms_lookup_name()
Message-ID: <20050218184203.GA23792@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1108751348.20053.1756.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108751348.20053.1756.camel@dyn318077bld.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2005 at 10:29:08AM -0800, Badari Pulavarty wrote:
> Hi,
> 
> Trivial patch to export kallsyms_lookup_name() for
> kprobe/jprobe module use.
> 
> Please apply. 
> 
> (BTW, I personally don't care if it should be
> EXPORT_SYMBOL_GPL or EXPORT_SYMBOL).

Certainly should be _GPL.  And where's the example user?
