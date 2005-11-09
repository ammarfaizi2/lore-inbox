Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751532AbVKIXJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbVKIXJM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 18:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751541AbVKIXJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 18:09:12 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:167 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751532AbVKIXJK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 18:09:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nJnUX/PHCG8+7kjixPopnwIrl+9msMSxMdoEVUnzt/lUJ58zTACcykweBcRc9VIihukI8swg/qdMmqf38Qd1eFM8hcGyeaq7VI+pqH7rGFzaL972AKnExwpUnD7YLwfCuoQGsgkbAqygBU9uJgfp20SDNL3zDXi89s4McPOOEJ4=
Message-ID: <9a8748490511091509t226fcffcw70dd40e67a6d36ac@mail.gmail.com>
Date: Thu, 10 Nov 2005 00:09:10 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: merge status
Cc: James Bottomley <James.Bottomley@steeleye.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, len.brown@intel.com, jgarzik@pobox.com,
       tony.luck@intel.com, bcollins@debian.org, scjody@modernduck.com,
       dwmw2@infradead.org, rolandd@cisco.com, davej@codemonkey.org.uk,
       axboe@suse.de, shaggy@austin.ibm.com, sfrench@us.ibm.com
In-Reply-To: <20051109150141.0bcbf9e3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051109133558.513facef.akpm@osdl.org>
	 <1131573041.8541.4.camel@mulgrave>
	 <Pine.LNX.4.64.0511091358560.4627@g5.osdl.org>
	 <1131575124.8541.9.camel@mulgrave>
	 <20051109150141.0bcbf9e3.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/05, Andrew Morton <akpm@osdl.org> wrote:
> James Bottomley <James.Bottomley@SteelEye.com> wrote:
> >
> > it's my contributors who drop me in it
> > by leaving their patch sets until you declare a kernel, dumping the
> > integration testing on me in whatever time window is left.
>
> Yes, I think I'm noticing an uptick in patches as soon as a kernel is
> released.
>
> It's a bit irritating, and is unexpected (here, at least).  I guess people
> like to hold onto their work for as long as possible so when they release
> it, it's in the best possible shape.
>
> I guess all we can do is to encourage people to merge up when it's working,
> not when it's time to merge it into mainline.
>
> One could just say "if I don't have it by the time 2.6.n is released, it
> goes into 2.6.n+2", but that's probably getting outside the realm of
> practicality.

I personally find that a nice flow is to just continuously push
patches to you to merge into -mm, then once the merge window opens you
usually push the stuff onto Linus and it'll make the next kernel.
Anything I submit after the merge window opens will just stay in -mm
and wait for the next merge window (or next+1 depending on the patch).

But then my stuff is usually quite simple, so I guess that doesn't
work for everyone, but for me at least it seems to work well.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
