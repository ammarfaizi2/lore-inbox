Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267304AbUJWLK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267304AbUJWLK1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 07:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267312AbUJWLK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 07:10:27 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:38580 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267304AbUJWLKT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 07:10:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=QLdeQrX10hk6BjvYONkVorWiZq9AakF+yq09gz9+ZRRXi+Xv7zGrh/S6WfomxSPXfdPYniaONyyHIyTb86HQ/L93LZ2QvXXfLgzTn2EIT+PRU+xotkcSFE0+adIgY1Q1juBoxuDYNT0Z6G/qLw8Zc0pSYaNla+H04V8S/BOOzQo=
Message-ID: <1a56ea3904102304103d2a3fbf@mail.gmail.com>
Date: Sat, 23 Oct 2004 12:10:18 +0100
From: DaMouse <damouse@gmail.com>
Reply-To: DaMouse <damouse@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: bkbits - "@" question
In-Reply-To: <20041023125943.266b658c.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <2SmNe-6MO-1@gated-at.bofh.it> <2SqR0-10Q-9@gated-at.bofh.it>
	 <20041023121452.1e82a758.khali@linux-fr.org>
	 <20041023102131.GA30449@infradead.org>
	 <20041023125943.266b658c.khali@linux-fr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Oct 2004 12:59:43 +0200, Jean Delvare <khali@linux-fr.org> wrote:
> > On Sat, Oct 23, 2004 at 12:14:52PM +0200, Jean Delvare wrote:
> > > > * Larry McVoy asked:
> > > > The web pages on bkbits.net contain email addresses.  This is
> > > > probably about a 4 year too late question but would it help reduce
> > > > spam if we did something like  s/@/ (at) / for all those
> > > > addresses?
> > > >
> > > > * Christoph Hellwig answered:
> > > > No.
> > >
> > > Why not, please?
> >
> > Because spambots parse all this replacements anyway, and it makes cut
> > & pasting mail addresses if you want to reply to a change much easier.
> 
> Strongly depends on how this is done. Of course, replacing
> user@domain.org by user(at)domain.org or even user AT domain DOT org
> won't help. However, I wonder what amount of spambots will spot user:
> domain org as a valid e-mail address.
> 
> There are also HTML+CSS tricks that should work well. Split the address
> over right-floating span elements, these will display in the reverse
> order. I doubt that the spambots will get it right.
> 
> I don't think that the cut'n'paste ability argument weights much here.
> How often do you do that?
> 
> Thanks.
> 
> 
> 
> --
> Jean Delvare
> http://khali.linux-fr.org/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Why not just have a PHP contact form instead with some of the well
known PHP security things in it such as an auth number box or whatnot.

-DaMouse

-- 
I know I broke SOMETHING but its there fault for not fixing it before me
