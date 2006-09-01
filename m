Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWIAQNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWIAQNx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 12:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWIAQNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 12:13:53 -0400
Received: from pat.uio.no ([129.240.10.4]:56014 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932220AbWIAQNw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 12:13:52 -0400
Subject: Re: [NFS] [PATCH 019 of 19] knfsd: Register all RPC programs with
	portmapper by default
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Chuck Lever <chucklever@gmail.com>
Cc: NeilBrown <neilb@suse.de>, Andrew Morton <akpm@osdl.org>,
       Olaf Kirch <okir@suse.de>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <76bd70e30609010831m9e80cfav514d60718d35e7d5@mail.gmail.com>
References: <20060901141639.27206.patches@notabene>
	 <1060901043948.27677@suse.de>
	 <76bd70e30609010831m9e80cfav514d60718d35e7d5@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 12:13:34 -0400
Message-Id: <1157127214.5632.62.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.308, required 12,
	autolearn=disabled, AWL 1.69, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 11:31 -0400, Chuck Lever wrote:

> I don't like this.  The idea that multiple RPC services are listening
> on the same port is a total hack.  What other service might use this
> besides NFSACL?

Ermm... Any RPC server process that doesn't want to register with the
portmapper. The NFSv4 callback channel is one obvious candidate.

Cheers,
  Trond

