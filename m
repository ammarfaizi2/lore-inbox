Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262407AbTJJHCf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 03:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbTJJHCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 03:02:35 -0400
Received: from pizda.ninka.net ([216.101.162.242]:63457 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262407AbTJJHCe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 03:02:34 -0400
Date: Thu, 9 Oct 2003 23:56:53 -0700
From: "David S. Miller" <davem@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: Re: [TRIVIAL] Fix initialization sequence in SunGEM driver
Message-Id: <20031009235653.26e509c1.davem@redhat.com>
In-Reply-To: <20031009070649.GA830@zax>
References: <20031009070649.GA830@zax>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Applied, thanks David.

But in the future please send net driver fixes to netdev@oss.sgi.com
with either Jeff Garzik or myself CC:'d?  Thanks.

I also would absolutely not classify your patch as "trivial".
It's not like a missing semi-colon or a comment typo, someone
with real understanding of how this stuff works would need to
review this patch.

Based just upon the kinds of networking patches Linus has forwarded
to me today, I can duly say that far too much stuff is being sent
as "[TRIVIAL]" which is not.
