Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262064AbVBPQNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbVBPQNs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 11:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbVBPQL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 11:11:29 -0500
Received: from ns.suse.de ([195.135.220.2]:46484 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262064AbVBPQLE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 11:11:04 -0500
Subject: Re: [patch 8/13] Add noacl nfs mount option
From: Andreas Gruenbacher <agruen@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Neil Brown <neilb@cse.unsw.edu.au>, Olaf Kirch <okir@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Buck Huppmann <buchk@pobox.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1108488257.10073.36.camel@lade.trondhjem.org>
References: <20050122203326.402087000@blunzn.suse.de>
	 <20050122203619.669767000@blunzn.suse.de>
	 <1108488257.10073.36.camel@lade.trondhjem.org>
Content-Type: text/plain
Organization: SUSE Labs
Message-Id: <1108570259.30082.110.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 16 Feb 2005 17:10:59 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-15 at 18:24, Trond Myklebust wrote:
> lau den 22.01.2005 Klokka 21:34 (+0100) skreiv Andreas Gruenbacher:
> > vanlig tekstdokument vedlegg (patches.suse)
> > With the noacl mount option, nfs clients stop using the ACCESS RPC
> > which they usually use to get an access decision from the server.
> > Instead, they make the decision based on the file ownership and
> > file mode permission bits.
> 
> I still hate that name "noacl".

So how would you call it? I'm not religious about the name.

Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX GMBH

