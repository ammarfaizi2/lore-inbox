Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262272AbVDGJT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbVDGJT5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 05:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbVDGJT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 05:19:57 -0400
Received: from ozlabs.org ([203.10.76.45]:52716 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262272AbVDGJT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 05:19:56 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16980.64324.87931.513333@cargo.ozlabs.ibm.com>
Date: Thu, 7 Apr 2005 19:20:04 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: David Woodhouse <dwmw2@infradead.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM saga..
In-Reply-To: <20050407015019.4563afe0.akpm@osdl.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
	<1112858331.6924.17.camel@localhost.localdomain>
	<20050407015019.4563afe0.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> The problem with those is letting other people get access to it.  I guess
> that could be fixed with a bit of scripting and rsyncing.

Yes.

> (I don't do that for -mm because -mm basically doesn't work for 99% of the
> time.  Takes 4-5 hours to out a release out assuming that nothing's busted,
> and usually something is).

With -mm we get those nice little automatic emails saying you've put
the patch into -mm, which removes one of the main reasons for wanting
to be able to get an up-to-date image of your tree.  The other reason,
of course, is to be able to see if a patch I'm about to send conflicts
with something you have already taken, and rebase it if necessary.

Paul.
