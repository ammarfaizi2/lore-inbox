Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266136AbUH2HPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266136AbUH2HPS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 03:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267189AbUH2HPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 03:15:18 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:47694 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S266136AbUH2HPN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 03:15:13 -0400
Date: Sun, 29 Aug 2004 09:16:35 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Keith Owens <kaos@sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, Patrick Gefre <pfg@sgi.com>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Latest Altix I/O code reorganization code
Message-ID: <20040829071635.GB7325@mars.ravnborg.org>
Mail-Followup-To: Keith Owens <kaos@sgi.com>,
	Christoph Hellwig <hch@infradead.org>, Patrick Gefre <pfg@sgi.com>,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20040827172131.A473@infradead.org> <28819.1093761574@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28819.1093761574@ocs3.ocs.com.au>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2004 at 04:39:34PM +1000, Keith Owens wrote:
> On Fri, 27 Aug 2004 17:21:31 +0100, 
> Christoph Hellwig <hch@infradead.org> wrote:
> >all files: lots of missing statics, try running
> >http://samba.org/ftp/unpacked/junkcode/findstatic.pl over the compiled code.
> 
> ftp://ftp.ocs.com.au/pub/namespace.pl does a more rigorous check for
> symbols that can be static.  namespace.pl knows about the special
> kernel symbols, linkage and EXPORT_SYMBOL().

Should we add it to the support scripts in the kernel?
Something like: 

make checknamespace

	Sam
