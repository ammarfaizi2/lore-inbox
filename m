Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbULAEzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbULAEzs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 23:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbULAEzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 23:55:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:20449 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261248AbULAEzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 23:55:38 -0500
Date: Tue, 30 Nov 2004 20:55:33 -0800
From: Chris Wright <chrisw@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Michael Kerrisk <michael.kerrisk@gmx.net>,
       Linus Torvalds <torvalds@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shmtcl SHM_LOCK perms
Message-ID: <20041130205533.O2357@build.pdx.osdl.net>
References: <20041130125045.E2357@build.pdx.osdl.net> <Pine.LNX.4.44.0412010049520.3344-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0412010049520.3344-100000@localhost.localdomain>; from hugh@veritas.com on Wed, Dec 01, 2004 at 01:00:13AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Hugh Dickins (hugh@veritas.com) wrote:
> But that's not the only reason for SHM_LOCK, and all you're telling us
> there is that the owner of sensitive data should be careful who they
> give read permission to - indeed!  So I still tend to agree with
> Michael, that the most natural restriction is to owner or creator -
> relax that if some app actually has a good case for relaxing it.

Yup, I agree.

thanks,
-chris
