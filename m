Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030446AbVIVQzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030446AbVIVQzn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 12:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030448AbVIVQzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 12:55:43 -0400
Received: from pat.uio.no ([129.240.130.16]:10888 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030446AbVIVQzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 12:55:42 -0400
Subject: Re: [PATCH] nfs client: handle long symlinks properly
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Assar <assar@permabit.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Peter Staubach <staubach@redhat.com>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <78u0gd2h39.fsf@sober-counsel.permabit.com>
References: <20050922161420.GC5588@dmt.cnet>
	 <1127406811.8365.8.camel@lade.trondhjem.org>
	 <78u0gd2h39.fsf@sober-counsel.permabit.com>
Content-Type: text/plain
Date: Thu, 22 Sep 2005 12:55:18 -0400
Message-Id: <1127408118.8365.28.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.082, required 12,
	autolearn=disabled, AWL 0.92, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 22.09.2005 Klokka 12:38 (-0400) skreiv Assar:
> Wouldn't len == rcvbuf->page_len - sizeof(u32) mean that there isn't
> room for writing the terminating NUL?

Yep. My bad... I was screwing up the test in my mind.

Cheers,
  Trond

