Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261719AbULGJFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbULGJFX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 04:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbULGJFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 04:05:22 -0500
Received: from [213.146.154.40] ([213.146.154.40]:1006 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261719AbULGJDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 04:03:43 -0500
Date: Tue, 7 Dec 2004 09:03:42 +0000
From: Christoph Hellwig <hch@infradead.org>
To: comsatcat <comsatcat@earthlink.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: qla2xxx fail over bug?
Message-ID: <20041207090342.GB13591@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	comsatcat <comsatcat@earthlink.net>, linux-kernel@vger.kernel.org
References: <1102399799.12866.3.camel@solaris.skunkware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102399799.12866.3.camel@solaris.skunkware.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Dec  6 23:05:26 fe-nntp-07 kernel: qla2x00: no more failovers for
> request - pid= 2210820
> 
> This message would scroll continuously.
> 
> Any comments or ideas?  Is this a bug or a feature?

There's not such printk in the kernel qla2xxx driver, so the bugs is
in front of the computer as you patched in a bogus vendor driver.

