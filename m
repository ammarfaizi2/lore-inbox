Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267263AbUJWK6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267263AbUJWK6h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 06:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267330AbUJWK6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 06:58:36 -0400
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:13840 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S267263AbUJWK6U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 06:58:20 -0400
Date: Sat, 23 Oct 2004 12:59:43 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bkbits - "@" question
Message-Id: <20041023125943.266b658c.khali@linux-fr.org>
In-Reply-To: <20041023102131.GA30449@infradead.org>
References: <2SmNe-6MO-1@gated-at.bofh.it>
	<2SqR0-10Q-9@gated-at.bofh.it>
	<20041023121452.1e82a758.khali@linux-fr.org>
	<20041023102131.GA30449@infradead.org>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, Oct 23, 2004 at 12:14:52PM +0200, Jean Delvare wrote:
> > > * Larry McVoy asked:
> > > The web pages on bkbits.net contain email addresses.  This is
> > > probably about a 4 year too late question but would it help reduce
> > > spam if we did something like  s/@/ (at) / for all those
> > > addresses?
> > >
> > > * Christoph Hellwig answered:
> > > No.
> > 
> > Why not, please?
> 
> Because spambots parse all this replacements anyway, and it makes cut
> & pasting mail addresses if you want to reply to a change much easier.

Strongly depends on how this is done. Of course, replacing
user@domain.org by user(at)domain.org or even user AT domain DOT org
won't help. However, I wonder what amount of spambots will spot user:
domain org as a valid e-mail address.

There are also HTML+CSS tricks that should work well. Split the address
over right-floating span elements, these will display in the reverse
order. I doubt that the spambots will get it right.

I don't think that the cut'n'paste ability argument weights much here.
How often do you do that?

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
