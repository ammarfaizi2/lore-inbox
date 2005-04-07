Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262289AbVDGIud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262289AbVDGIud (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 04:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262313AbVDGIud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 04:50:33 -0400
Received: from fire.osdl.org ([65.172.181.4]:404 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262289AbVDGIu3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 04:50:29 -0400
Date: Thu, 7 Apr 2005 01:50:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM saga..
Message-Id: <20050407015019.4563afe0.akpm@osdl.org>
In-Reply-To: <1112858331.6924.17.camel@localhost.localdomain>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
	<1112858331.6924.17.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:
>
> One feature I'd want to see in a replacement version control system is
>  the ability to _re-order_ patches, and to cherry-pick patches from my
>  tree to be sent onwards.

You just described quilt & patch-scripts.

The problem with those is letting other people get access to it.  I guess
that could be fixed with a bit of scripting and rsyncing.

(I don't do that for -mm because -mm basically doesn't work for 99% of the
time.  Takes 4-5 hours to out a release out assuming that nothing's busted,
and usually something is).

