Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751478AbWCGTkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbWCGTkk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 14:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWCGTkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 14:40:40 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:6761 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751478AbWCGTkj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 14:40:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cEt0vSLBMXkddNkFryNb34qJj25QMOkVwPCHd7z9/8YSk2X9suJGft5a+75iXpRJZUIFkgsAXYld+Z7IWkeqtqo4l1kgeBxhj8TAhbP/K6ZniVc2U6D9GTezNyq6swVEr8C03YMCvdURQd0DacweqhhcRRrVIEkZUOK80B3Aa98=
Message-ID: <9a8748490603071140x2a67c022m2448dafc8fa21552@mail.gmail.com>
Date: Tue, 7 Mar 2006 20:40:37 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "James Bottomley" <James.Bottomley@steeleye.com>
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       "Mike Christie" <michaelc@cs.wisc.edu>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, markhe@nextd.demon.co.uk, andrea@suse.de,
       axboe@suse.de, penberg@cs.helsinki.fi
In-Reply-To: <1141754512.3239.41.camel@mulgrave.il.steeleye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200603060117.16484.jesper.juhl@gmail.com>
	 <Pine.LNX.4.64.0603061402410.13139@g5.osdl.org>
	 <Pine.LNX.4.64.0603061423160.13139@g5.osdl.org>
	 <Pine.LNX.4.64.0603061445350.13139@g5.osdl.org>
	 <9a8748490603061501r387291f0ha10e9e9fe3c9e060@mail.gmail.com>
	 <20060306150612.51f48efa.akpm@osdl.org>
	 <9a8748490603061524j616bf6b3i1b6ab5354bcfe1a9@mail.gmail.com>
	 <440CFABF.5040403@cs.wisc.edu>
	 <Pine.LNX.4.64.0603061917330.3573@g5.osdl.org>
	 <1141754512.3239.41.camel@mulgrave.il.steeleye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/06, James Bottomley <James.Bottomley@steeleye.com> wrote:
> On Mon, 2006-03-06 at 19:20 -0800, Linus Torvalds wrote:
> > > should be added back I think.
> >
> > Good eyes. I bet that's it.
>
> Yes, well done.  Do we have confirmation yet that reversing this fixes
> the bug?
>

I just tried reverting that bit only from 2.6.16-rc5-mm2, and it does
indeed fix the problem.

Thanks for spotting that Mike.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
