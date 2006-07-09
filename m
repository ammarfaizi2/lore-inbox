Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161109AbWGIULi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161109AbWGIULi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 16:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161118AbWGIULi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 16:11:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:49082 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161109AbWGIULh (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 16:11:37 -0400
Date: Sun, 9 Jul 2006 21:11:28 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Vladimir V. Saveliev" <vs@namesys.com>
Cc: Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>,
       Linux-Kernel@vger.kernel.org, reiserfs-dev@namesys.com, mm@us.ibm.com,
       shaggy@austin.ibm.com, nathans@sgi.com
Subject: Re: [PATCH 1/2] batch-write.patch
Message-ID: <20060709201128.GA31122@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Vladimir V. Saveliev" <vs@namesys.com>,
	Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>,
	Linux-Kernel@vger.kernel.org, reiserfs-dev@namesys.com,
	mm@us.ibm.com, shaggy@austin.ibm.com, nathans@sgi.com
References: <44A42750.5020807@namesys.com> <20060629185017.8866f95e.akpm@osdl.org> <1152011576.6454.36.camel@tribesman.namesys.com> <20060704114836.GA1344@infradead.org> <44AAA8ED.5030906@namesys.com> <20060704151832.9f2d87b3.akpm@osdl.org> <1152117935.6337.48.camel@tribesman.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152117935.6337.48.camel@tribesman.namesys.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2006 at 08:45:35PM +0400, Vladimir V. Saveliev wrote:
> ok, the attached is the final version of the patch.
> Please, take a look and make comments.

Perfect, this is exactly how I hoped it will be done in the end.  Very
nice massaging of the generic code without runtime impact on older filesystems
or code duplication.  Thanks a lot Vladimir!


Now before we can put this into mainline we'd need some in-tree filesystems
to make use of it.  I've cc'ed the usual suspects for this..

p.s. you mail setup seems a little odd.  any chance you could just inline
the patch normally instead of using mime?

