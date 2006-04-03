Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751737AbWDCPlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbWDCPlw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 11:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751738AbWDCPlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 11:41:52 -0400
Received: from pat.uio.no ([129.240.10.6]:60566 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751736AbWDCPlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 11:41:51 -0400
Subject: Re: NFS client (10x) performance regression 2.6.14.7 -> 2.6.15
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jakob Oestergaard <jakob@unthought.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060403152628.GA14981@unthought.net>
References: <1143807770.8096.4.camel@lade.trondhjem.org>
	 <20060331124518.GH9811@unthought.net>
	 <1143810392.8096.11.camel@lade.trondhjem.org>
	 <20060331132131.GI9811@unthought.net>
	 <1143812658.8096.18.camel@lade.trondhjem.org>
	 <20060331140816.GJ9811@unthought.net>
	 <1143814889.8096.22.camel@lade.trondhjem.org>
	 <20060331143500.GK9811@unthought.net>
	 <1143820520.8096.24.camel@lade.trondhjem.org>
	 <20060331160426.GN9811@unthought.net>
	 <20060403152628.GA14981@unthought.net>
Content-Type: text/plain
Date: Mon, 03 Apr 2006 11:41:40 -0400
Message-Id: <1144078900.9111.41.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-5, required 12,
	autolearn=disabled, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-03 at 17:26 +0200, Jakob Oestergaard wrote:
> I've run a git bisect from 2.6.14 to 2.6.15 to find what broke the NFS
> client.
> 
> It seems to be the GIT patch: 24aa1fe6779eaddb3e0b1b802585dcf6faf9cc44
> that introduces the problem.
> 
> Trond, it took me a lot of tries with GIT to narrow this down, because
> the problem does not show up consistently. Some times nfsbench would
> complete very quickly, but then a second (or third or ...) run would run
> slow.
> 
> Could I ask you to try: 
>  for i in `seq 1 100`; do time ./nfsbench; done
> or something like that?

OK. Thanks for helping narrow this down! I'm travelling right now, so I
can't promise that I'll be able to run any tests until tomorrow. I'll
have a look, though.

Cheers,
  Trond

