Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbWHYUht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbWHYUht (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 16:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422901AbWHYUhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 16:37:48 -0400
Received: from pat.uio.no ([129.240.10.4]:27614 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932466AbWHYUhr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 16:37:47 -0400
Subject: Re: [PATCH 4/6] nfs: Teach NFS about swap cache pages
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>
In-Reply-To: <1156537214.26945.6.camel@lappy>
References: <20060825153709.24254.28118.sendpatchset@twins>
	 <20060825153751.24254.20709.sendpatchset@twins>
	 <1156536228.5927.17.camel@localhost>  <1156537214.26945.6.camel@lappy>
Content-Type: text/plain
Date: Fri, 25 Aug 2006 16:37:34 -0400
Message-Id: <1156538255.5927.46.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.962, required 12,
	autolearn=disabled, AWL 2.04, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-25 at 22:20 +0200, Peter Zijlstra wrote:
> Indiscriminate search and replace followed by a manual check for
> correctness. They might not be needed, but they're not wrong either.
> 
> Would you prefer I take them out?

It won't give us any massive performance optimisations, but it is nice
to be able to avoid that call to test_bit() whenever possible.

Cheers,
  Trond

