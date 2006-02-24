Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932633AbWBXXBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932633AbWBXXBe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 18:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbWBXXBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 18:01:33 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:29634 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932633AbWBXXBd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 18:01:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JKv7EOAgSeHwq8Qb1UC/CEtC6LA6QCLGYxQ/NXMNIHaEo9pGhyaFpL7M7S12uNCL31C4aUk8V2lavG0aLiGyJ6df0PWd15CBViWsc3UChs7t+W8C5y/GcE9ireTSE2Ua7F+sLtBVJW9upf9wWUwXCzXALY2qtZL9FU1qVBLEZVo=
Message-ID: <9a8748490602241501q550488baqad63df65f4dd8623@mail.gmail.com>
Date: Sat, 25 Feb 2006 00:01:32 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>
Subject: Re: [PATCH 12/13] "const static" vs "static const" in nfs4
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Kendrick Smith" <kmsmith@umich.edu>, "Andy Adamson" <andros@umich.edu>,
       neilb@cse.unsw.edu.au
In-Reply-To: <1140821964.3615.95.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200602242149.42735.jesper.juhl@gmail.com>
	 <1140821964.3615.95.camel@lade.trondhjem.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/06, Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> On Fri, 2006-02-24 at 21:49 +0100, Jesper Juhl wrote:
> > My previous "const static" vs "static const" cleanup missed a single case,
> > patch below takes care of it.
> >
>
> I can shepherd that in for 2.6.17 (unless Andrew wants to make it a
> 2.6.16 priority?).
>

No need for that. It's just something that ICC complains about
"storage class not being first" - gcc doesn't care.

2.6.17 is fine, no need to rush that one.

Just a small thing that might as well be done :)

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
