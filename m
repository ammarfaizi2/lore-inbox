Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965026AbWHNW6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965026AbWHNW6N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 18:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965027AbWHNW6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 18:58:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26516 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965026AbWHNW6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 18:58:12 -0400
Date: Mon, 14 Aug 2006 15:58:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Eric Sandeen <esandeen@redhat.com>
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix ext3 mounts at 16T
Message-Id: <20060814155801.fa087b24.akpm@osdl.org>
In-Reply-To: <44DD00FA.5060600@redhat.com>
References: <44DD00FA.5060600@redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2006 17:13:14 -0500
Eric Sandeen <esandeen@redhat.com> wrote:

> (a similar patch could be done for ext2; does anyone in their right mind use ext2 at 16T?

well, a bug's a bug.  People might want to ue 16TB ext2 for comparative
performance testing, or because they get their jollies from running fsck or
something.

> I'll send an ext2 patch doing the same thing if that's warranted)

please, when you have nothing better to do ;)
