Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbWBXStv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbWBXStv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 13:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWBXStu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 13:49:50 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41375 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932424AbWBXStu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 13:49:50 -0500
Date: Fri, 24 Feb 2006 18:49:41 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jan Beulich <JBeulich@novell.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 double fault enhancements
Message-ID: <20060224184940.GA5816@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jan Beulich <JBeulich@novell.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <200602221159.08969.jbeulich@novell.com> <20060222143212.0eea2ab0.akpm@osdl.org> <43FDADA0.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FDADA0.76F0.0078.0@novell.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 12:42:08PM +0100, Jan Beulich wrote:
> >Can't we use CONFIG_DOUBLEFAULT throughout?  It's very much clearer.
> 
> We could, when not considering broader use. I specifically introduced N_EXCEPTION_TSS
> so that it wouldn't be as hard as it currently is to have other exceptions got through task
> gates (nlkd's fault/trap/abort infrastructure does, for example).

So please keep this in your out of tree patch.  In mainline it's just
needlessly obsfucating the code.

