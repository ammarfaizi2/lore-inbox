Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262032AbVBPRjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbVBPRjV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 12:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVBPRjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 12:39:20 -0500
Received: from ns.suse.de ([195.135.220.2]:3821 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262032AbVBPRjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 12:39:17 -0500
Subject: Re: [patch 10/13] Solaris nfsacl workaround
From: Andreas Gruenbacher <agruen@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Neil Brown <neilb@cse.unsw.edu.au>, Olaf Kirch <okir@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Buck Huppmann <buchk@pobox.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1108573547.10161.18.camel@lade.trondhjem.org>
References: <20050122203326.402087000@blunzn.suse.de>
	 <20050122203619.889966000@blunzn.suse.de>
	 <1108488547.10073.39.camel@lade.trondhjem.org>
	 <1108570666.30082.118.camel@winden.suse.de>
	 <1108573547.10161.18.camel@lade.trondhjem.org>
Content-Type: text/plain
Organization: SUSE Labs
Message-Id: <1108575550.30082.244.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 16 Feb 2005 18:39:10 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-02-16 at 18:05, Trond Myklebust wrote:
> I am, however, surprised when you say that Solaris has problems with
> this. The PROG_MISMATCH error does also tell the client the minimum and
> maximum supported version, so if all is working well, then it recognize
> that we support version 3 only. It seems wierd that they should then
> choose to treat that as an mount failure.

Well, yes. It's a weird bug.

Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX GMBH

