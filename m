Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbVB0Wxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVB0Wxz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 17:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVB0Wxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 17:53:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:15834 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261506AbVB0Wxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 17:53:44 -0500
Date: Sun, 27 Feb 2005 22:53:39 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>, Olaf Kirch <okir@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 10/16] Infrastructure and server side of nfsacl
Message-ID: <20050227225339.GB2168@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andreas Gruenbacher <agruen@suse.de>, linux-kernel@vger.kernel.org,
	Neil Brown <neilb@cse.unsw.edu.au>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Olaf Kirch <okir@suse.de>,
	"Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
	Andrew Morton <akpm@osdl.org>
References: <20050227152243.083308000@blunzn.suse.de> <20050227152353.191399000@blunzn.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050227152353.191399000@blunzn.suse.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2005 at 04:22:53PM +0100, Andreas Gruenbacher wrote:
> This adds functions for encoding and decoding POSIX ACLs for the NFSACL
> protocol extension, and the GETACL and SETACL RPCs.  The implementation is
> compatible with NFSACL in Solaris.

Can you add a new fs/nfscommon/ directory instead of adding the file directly
to fs/?  Especially as there could be some more bits shared by nfs client and
server.

