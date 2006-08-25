Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWHYNr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWHYNr3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 09:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWHYNr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 09:47:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:45771 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932222AbWHYNr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 09:47:28 -0400
Date: Fri, 25 Aug 2006 14:47:04 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stephane Eranian <eranian@hpl.hp.com>
Subject: Re: [PATCH 9/18] 2.6.17.9 perfmon2 patch for review: kernel-level interface
Message-ID: <20060825134704.GA21398@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Stephane Eranian <eranian@hpl.hp.com>
References: <200608250300_MC3-1-C942-6359@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608250300_MC3-1-C942-6359@compuserve.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 02:56:37AM -0400, Chuck Ebbert wrote:
> > Yes, I think we either need a stronger argument for including this code, or
> > we drop it.
> 
> This interface is for people writing kprobes who want to do performance
> monitoring within their probe code.  There will probably never be any
> in-kernel users, just like there are no in-kernel users of kprobes.

Wrong argument.  There is a in-tree user of kprobes and I plan to submit
a lot more.  If people want to write kprobes for performance mintoring
they should submit them for inclusion and we can then find a proper
API for it - the current one is rather horrible anyway.

