Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbVDMO67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVDMO67 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 10:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbVDMO67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 10:58:59 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:30166 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261360AbVDMO6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 10:58:51 -0400
Date: Wed, 13 Apr 2005 15:58:46 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] sound/oss/rme96xx.c: fix two check after use
Message-ID: <20050413145846.GA10017@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" <7eggert@gmx.de>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Adrian Bunk <bunk@stusta.de>
References: <3SGgN-41r-1@gated-at.bofh.it> <3SGA8-4n3-9@gated-at.bofh.it> <E1DLfIV-0000pl-Fa@be1.7eggert.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DLfIV-0000pl-Fa@be1.7eggert.dyndns.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 12:40:38PM +0200, Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org> wrote:
> If there are checks, they should be there for a purpose,

emphasis here is on _should_

> and any sane reader will asume these checks to be nescensary.

That's a bad assumptions when you're deadling with drivers or software of
similar quality.

> If they are dead code, you
> can say that, but please don't flame Adrian for fixing obviously buggy code
> in a way that is sane and at least more correct than the original without
> using several days of his lifetime to analyze the whole driver. Instead, you
> could provide the correct fix.

The correct fix is to remove the check.  And no, we don't have a rule that
someone must provide something better when trying to critize it.
