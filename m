Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262894AbTEGGQA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 02:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbTEGGQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 02:16:00 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:7945 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262894AbTEGGP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 02:15:59 -0400
Date: Wed, 7 May 2003 07:28:30 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "David S. Miller" <davem@redhat.com>
Cc: dwmw2@infradead.org, thomas@horsten.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__ defined (trivial)
Message-ID: <20030507072830.A7586@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"David S. Miller" <davem@redhat.com>, dwmw2@infradead.org,
	thomas@horsten.com, linux-kernel@vger.kernel.org
References: <20030507062613.A5318@infradead.org> <20030506.220714.35679546.davem@redhat.com> <20030507072002.A7424@infradead.org> <20030506.221900.38693097.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030506.221900.38693097.davem@redhat.com>; from davem@redhat.com on Tue, May 06, 2003 at 10:19:00PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 10:19:00PM -0700, David S. Miller wrote:
> What about if I extend stuff without breaking the ABI?
> How do apps get at the new features?

They get the features when they use the new headers.  They ususally want
changes to support those new features anyway..

> Actually, if you look, things like include/linux/xfrm.h are excellent
> examples of userland compatible kernel headers :-)

rtnetlink.h is a bad example.  Just to use something you quoted earlier in
this thread..

