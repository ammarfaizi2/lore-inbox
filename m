Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271289AbTGWUIW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 16:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271278AbTGWUIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 16:08:20 -0400
Received: from rth.ninka.net ([216.101.162.244]:41345 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S271289AbTGWUH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 16:07:59 -0400
Date: Wed, 23 Jul 2003 13:22:56 -0700
From: "David S. Miller" <davem@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: hch@lst.de, uclinux-dev@uclinux.org, linux-kernel@vger.kernel.org
Subject: Re: [uClinux-dev] Kernel 2.6 size increase
Message-Id: <20030723132256.58ee50e7.davem@redhat.com>
In-Reply-To: <20030723211533.A434@infradead.org>
References: <200307232046.46990.bernie@develer.com>
	<20030723193246.GA836@lst.de>
	<20030723131154.472172d0.davem@redhat.com>
	<20030723211533.A434@infradead.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jul 2003 21:15:33 +0100
Christoph Hellwig <hch@infradead.org> wrote:

> I just wanted to see whether gcc actually is smarter than us
> so we need to remove some more inlines..

Drivers weren't audited much, and there's a lot of boneheaded
stuff in this area.  But these should be mostly identical
to what would happen on the 2.4.x side
