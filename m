Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264362AbTKZVj2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 16:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264372AbTKZVj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 16:39:28 -0500
Received: from pizda.ninka.net ([216.101.162.242]:22423 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264362AbTKZVj1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 16:39:27 -0500
Date: Wed, 26 Nov 2003 13:38:51 -0800
From: "David S. Miller" <davem@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: tytso@mit.edu, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Fire Engine??
Message-Id: <20031126133851.6bf5e573.davem@redhat.com>
In-Reply-To: <20031126212406.GL14383@mail.shareable.org>
References: <BAY1-DAV15JU71pROHD000040e2@hotmail.com.suse.lists.linux.kernel>
	<20031125183035.1c17185a.davem@redhat.com.suse.lists.linux.kernel>
	<p73fzgbzca6.fsf@verdi.suse.de>
	<20031126113040.3b774360.davem@redhat.com>
	<20031126202216.GA13116@thunk.org>
	<20031126130254.010440e5.davem@redhat.com>
	<20031126212406.GL14383@mail.shareable.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Nov 2003 21:24:06 +0000
Jamie Lokier <jamie@shareable.org> wrote:

> recvmsg() doesn't return timestamps until they are requested
> using setsockopt(...SO_TIMESTAMP...).
> 
> See sock_recv_timestamp() in include/net/sock.h.

See MSG_ERRQUEUE and net/ipv4/ip_sockglue.c
