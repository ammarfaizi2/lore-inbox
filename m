Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932672AbVIHPQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932672AbVIHPQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932680AbVIHPQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:16:26 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:26817 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932672AbVIHPQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:16:25 -0400
Date: Thu, 8 Sep 2005 16:16:24 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rmmod notifier chain
Message-ID: <20050908151624.GA11067@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jan Beulich <JBeulich@novell.com>, linux-kernel@vger.kernel.org
References: <43206EFE0200007800024451@emea1-mh.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43206EFE0200007800024451@emea1-mh.id2.novell.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2005 at 05:03:58PM +0200, Jan Beulich wrote:
> (Note: Patch also attached because the inline version is certain to get
> line wrapped.)
> 
> Debugging and maintenance support code occasionally needs to know not
> only of module insertions, but also modulke removals. This adds a
> notifier
> chain for this purpose.

I don't think this should be exported, _GPL if at all.  And it certainly
shouldn't go in without an actual user.

