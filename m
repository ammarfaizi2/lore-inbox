Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272226AbTHDV4D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 17:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272264AbTHDV4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 17:56:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:16100 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272226AbTHDV4B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 17:56:01 -0400
Date: Mon, 4 Aug 2003 14:57:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: jbarnes@sgi.com (Jesse Barnes)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make lookup_create non-static
Message-Id: <20030804145723.533e77f7.akpm@osdl.org>
In-Reply-To: <20030804214412.GA1788@sgi.com>
References: <20030804213543.GA1697@sgi.com>
	<20030804144129.3dfe4aac.akpm@osdl.org>
	<20030804214412.GA1788@sgi.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jbarnes@sgi.com (Jesse Barnes) wrote:
>
> You mean copy lookup_create into hwgfs (which is already in the tree,
>  btw)?  Yeah, I guess I could do that if you don't want to take this.

ah, I thought you were referring to an out-of-tree filesystem.

It would appear that intermezzo has already created a private copy of
lookup_create().  Sigh.

If we're going to export this thing to filesystems then it really should be
documented a bit.  You could bribe me with a patch which does that ;)
