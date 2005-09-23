Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbVIWTTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbVIWTTI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 15:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbVIWTTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 15:19:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65466 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751176AbVIWTTF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 15:19:05 -0400
Date: Fri, 23 Sep 2005 12:18:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Sykes <chris@sigsegv.plus.com>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: Hang during rm on ext2 mounted sync (2.6.14-rc2+)
Message-Id: <20050923121811.2ef1f0be.akpm@osdl.org>
In-Reply-To: <20050923132216.GA5784@sigsegv.plus.com>
References: <20050922163708.GF5898@sigsegv.plus.com>
	<20050923015719.5eb765a4.akpm@osdl.org>
	<20050923121932.GA5395@sigsegv.plus.com>
	<20050923132216.GA5784@sigsegv.plus.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Sykes <chris@sigsegv.plus.com> wrote:
>
> I'll try to track down the changeset between 2.6.13-git9 and
>  2.6.13-git10 that causes this for me

That would be ideal, thanks.  Grab the latest from
http://www.kernel.org/pub/software/scm/git/ and take a look at
Documentation/git-bisect-script.txt

We ought to have the git bisection process documented in the kernel tree,
but we don't, alas.  There's stuff at http://lkml.org/lkml/2005/6/24/234
but a standalone document which walks people through installing git,
pulling the initial tree, building and bisecting is needed (hint).

