Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbUB2Waj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 17:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbUB2Waj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 17:30:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:6854 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262205AbUB2Wai convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 17:30:38 -0500
Date: Sun, 29 Feb 2004 14:31:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-rc1-mm1
Message-Id: <20040229143145.1499e568.akpm@osdl.org>
In-Reply-To: <20040229222415.A32236@infradead.org>
References: <20040229140617.64645e80.akpm@osdl.org>
	<20040229222415.A32236@infradead.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sun, Feb 29, 2004 at 02:06:17PM -0800, Andrew Morton wrote:
> > +scsi-external-build-fix.patch
> > 
> > Fix scsi.h for inclusion by userspace apps - it used to work, so...
> 
> This has been rejected on linux-scsi a few times.  Don't use include/scsi/
> from the kerneltree - there's alredy a /usr/include/scsi from glibc anyway,
> so the situation is even more clear thæn the general you should not include
> kernel headers thing.

hm, OK.  If it works in 2.4 and doesn't work in 2.6 I'd consider that a
regression.  And as the fix is so trivial, I'd consider failure to fix it
as pure dogmatism.  But whatever, I'm utterly bored of this discussion. 
Consider it dropped.

