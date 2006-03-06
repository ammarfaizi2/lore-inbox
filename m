Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751678AbWCFXYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbWCFXYq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 18:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751952AbWCFXYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 18:24:45 -0500
Received: from pproxy.gmail.com ([64.233.166.181]:14691 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751678AbWCFXYp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 18:24:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e3IVYgGIO3S1xdNYz82PGLCSUT0UlXnXhSnu4rozA2sCBcAMCBY1itqSMY/acBd9hkff2uXNAZUmT19Hl+jvLhzMvekbg1bWTv/2FYICniV42x3VLgMgREYZW7sIqf2LDfnbFMORSBRmgudrmeV1uwRfZvXIh/H8jlRzRqpt3YA=
Message-ID: <9a8748490603061524j616bf6b3i1b6ab5354bcfe1a9@mail.gmail.com>
Date: Tue, 7 Mar 2006 00:24:44 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, markhe@nextd.demon.co.uk,
       andrea@suse.de, michaelc@cs.wisc.edu, James.Bottomley@steeleye.com,
       axboe@suse.de, penberg@cs.helsinki.fi
In-Reply-To: <20060306150612.51f48efa.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200603060117.16484.jesper.juhl@gmail.com>
	 <9a8748490603061253u5e4d7561vd4e566f5798a5f4@mail.gmail.com>
	 <9a8748490603061256h794c5af9wa6fbb616e8ddbd89@mail.gmail.com>
	 <Pine.LNX.4.64.0603061306300.13139@g5.osdl.org>
	 <9a8748490603061354vaa53c72na161d26065b9302e@mail.gmail.com>
	 <Pine.LNX.4.64.0603061402410.13139@g5.osdl.org>
	 <Pine.LNX.4.64.0603061423160.13139@g5.osdl.org>
	 <Pine.LNX.4.64.0603061445350.13139@g5.osdl.org>
	 <9a8748490603061501r387291f0ha10e9e9fe3c9e060@mail.gmail.com>
	 <20060306150612.51f48efa.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/06, Andrew Morton <akpm@osdl.org> wrote:
> "Jesper Juhl" <jesper.juhl@gmail.com> wrote:
> >
> > And since 2.6.16-rc5-git8 is not experiencing problems I'd suggest you
> >  perhaps instead take a look at what's in -mm... That's where we need
> >  to work (it seems) to find the bug...
>
> Yes, it's very probably something in git-scsi-misc.
>
I would say that's correct. I just build 2.6.16-rc5-mm2 with just
git-scsi-misc.patch reverted, and that makes the problem go away.

So now the big question is; what part(s) of git-scsi-misc is broken?

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
