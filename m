Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266708AbUH0RPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266708AbUH0RPn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 13:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266705AbUH0RPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 13:15:43 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:2571 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266704AbUH0RPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 13:15:40 -0400
Date: Fri, 27 Aug 2004 18:15:38 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Patrick Gefre <pfg@sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Latest Altix I/O code reorganization code
Message-ID: <20040827181538.A1173@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Patrick Gefre <pfg@sgi.com>, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <200408042014.i74KE8fD141211@fsgi900.americas.sgi.com> <20040806141836.A9854@infradead.org> <411AAABB.8070707@sgi.com> <412F4EC9.7050003@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <412F4EC9.7050003@sgi.com>; from pfg@sgi.com on Fri, Aug 27, 2004 at 10:10:01AM -0500
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 10:10:01AM -0500, Patrick Gefre wrote:
> 
> This is an update to our last set of patches. I've added some comments from the
> last review and another synopsis of the patches. The individual patches will
> follow this email.

The header changes in your patchkit are still rather strange, you're e.g.
adding a pfn_t or clusterid_t but never using it.  As suggested in a previous
mail please also provide a clean set of headers in addition to the clean set
of source files.  There's lots of dead wood in thos and with all the code
gone youshould be able to kill off all the IRIX-compat gunk, etc..

