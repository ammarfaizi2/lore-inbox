Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266006AbUH0Par@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266006AbUH0Par (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 11:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265999AbUH0P2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 11:28:07 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:59658 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266117AbUH0PV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 11:21:28 -0400
Date: Fri, 27 Aug 2004 16:21:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Patrick Gefre <pfg@sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Latest Altix I/O code reorganization code
Message-ID: <20040827162127.A32090@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Patrick Gefre <pfg@sgi.com>, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <200408042014.i74KE8fD141211@fsgi900.americas.sgi.com> <20040806141836.A9854@infradead.org> <411AAABB.8070707@sgi.com> <412F4EC9.7050003@sgi.com> <412F4FCF.6010507@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <412F4FCF.6010507@sgi.com>; from pfg@sgi.com on Fri, Aug 27, 2004 at 10:14:23AM -0500
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 10:14:23AM -0500, Patrick Gefre wrote:
> 
> Patch 1 of 26
> 
> This patch is too large for email see:
> 
> ftp://oss.sgi.com/projects/sn2/sn2-update/001-kill-files


Stoop again.  This absolutely does not look like a change after which the
tree build, right?  After how many of the patches do we get a useable
kernel for SN2?  Please split your changes into LOGICAL steps, e.g.

 - dma mapping rework
 - usage of SAL interfaces
 - hwgrpah removal
 - renaming of files without code changes
 - addition of new hardware support
 - etc..

everything else is simply not reviewable. (and the above is intentionally
an order which I think would make sense)

