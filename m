Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263534AbTKDAJn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 19:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263538AbTKDAJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 19:09:43 -0500
Received: from rth.ninka.net ([216.101.162.244]:24193 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263534AbTKDAJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 19:09:42 -0500
Date: Mon, 3 Nov 2003 17:09:35 -0800
From: "David S. Miller" <davem@redhat.com>
To: Dan Kegel <dkegel@ixiacom.com>
Cc: fleury@cs.auc.dk, linux-kernel@vger.kernel.org
Subject: Re: allocating netlink families? (was: re: Announce: NetKeeper
 Firewall For Linux)
Message-Id: <20031103170935.5c6688b9.davem@redhat.com>
In-Reply-To: <3FA6F628.70305@ixiacom.com>
References: <3FA6F628.70305@ixiacom.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Nov 2003 16:43:20 -0800
Dan Kegel <dkegel@ixiacom.com> wrote:

> Has there been any discussion of how one should pick
> netlink family numbers for new stuff like netkeeper?
> Sure, everyone could use NETLINK_USERSOCK, but
> that means only one new netlink module could be resident at a time...

When it's determined to be useful and to be added to
the main kernel sources, we'll allocate a number.
Before that time, there is no need to allocate.  We'd
run out quickly if everyone with a funny netlink thing they
wanted to do asked for a number.
