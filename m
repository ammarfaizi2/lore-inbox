Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264776AbTIDITw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 04:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264805AbTIDITv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 04:19:51 -0400
Received: from pizda.ninka.net ([216.101.162.242]:6572 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264776AbTIDITv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 04:19:51 -0400
Date: Thu, 4 Sep 2003 01:10:10 -0700
From: "David S. Miller" <davem@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: hch@lst.de, paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix ppc ioremap prototype
Message-Id: <20030904011010.21857a1c.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0309040111290.20151-100000@home.osdl.org>
References: <20030904010940.5fa0e560.davem@redhat.com>
	<Pine.LNX.4.44.0309040111290.20151-100000@home.osdl.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Sep 2003 01:12:28 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> Actually, my suggestion right now is to ignore the issue, and let the 
> current ppc440x code stand as-is. After all, it works, and it does what 
> the ppc people want. We may at some point switch over _all_ ioremap users, 
> but there is no real reason to do so right now.

Ok, that's fine.

What we could do in the interim is create an ioremap_resource()
and then move things over gradually.
