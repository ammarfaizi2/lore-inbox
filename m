Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265183AbUD3NGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265183AbUD3NGX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 09:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265182AbUD3NGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 09:06:23 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:39941 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265183AbUD3NGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 09:06:19 -0400
Date: Fri, 30 Apr 2004 14:06:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Rik van Riel <riel@redhat.com>
Cc: Erik Jacobson <erikj@subway.americas.sgi.com>, Paul Jackson <pj@sgi.com>,
       chrisw@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Process Aggregates (PAGG) support for the 2.6 kernel
Message-ID: <20040430140611.A11636@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Rik van Riel <riel@redhat.com>,
	Erik Jacobson <erikj@subway.americas.sgi.com>,
	Paul Jackson <pj@sgi.com>, chrisw@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040430071750.A8515@infradead.org> <Pine.LNX.4.44.0404300853230.6976-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0404300853230.6976-100000@chimarrao.boston.redhat.com>; from riel@redhat.com on Fri, Apr 30, 2004 at 08:54:08AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2004 at 08:54:08AM -0400, Rik van Riel wrote:
> What was the last time you looked at the CKRM source?

the day before yesterday (the patch in SuSE's tree because there
doesn't seem to be any official patch on their website)

> Sure it's a bit bigger than PAGG, but that's also because
> it includes the functionality to change the group a process
> belongs to and other things that don't seem to be included
> in the PAGG patch.

Again, pagg doesn't even play in that league.  It's really just a tiny
meachnism to allow a kernel module keep per-process data.  Policies
like process-groups can be implemented ontop of that.

