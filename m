Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751526AbWB0RZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbWB0RZA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 12:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbWB0RZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 12:25:00 -0500
Received: from hera.kernel.org ([140.211.167.34]:60610 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751519AbWB0RY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 12:24:59 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Building 100 kernels; we suck at dependencies and drown in
 warnings
Date: Mon, 27 Feb 2006 09:25:01 -0800
Organization: OSDL
Message-ID: <20060227092501.7be9b1a2@localhost.localdomain>
References: <200602261721.17373.jesper.juhl@gmail.com>
	<1140986578.24141.141.camel@mindpipe>
	<87wtfh3i9z.fsf@hades.wkstn.nix>
	<9a8748490602261349v381933b9xeb2ddeedac053910@mail.gmail.com>
	<1140990819.24141.176.camel@mindpipe>
	<9a8748490602261356l222c9689w8fa1d5e2395bb183@mail.gmail.com>
	<1140991706.24141.183.camel@mindpipe>
	<9a8748490602261412x6f610253mf0a991bd76cded89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1141061092 26977 10.8.0.54 (27 Feb 2006 17:24:52 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Mon, 27 Feb 2006 17:24:52 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Feb 2006 23:12:51 +0100
"Jesper Juhl" <jesper.juhl@gmail.com> wrote:

> On 2/26/06, Lee Revell <rlrevell@joe-job.com> wrote:
> > On Sun, 2006-02-26 at 22:56 +0100, Jesper Juhl wrote:
> > > Yeah so gcc is not perfect, but that still doesn't change that the
> > > intention of the warning and the use of the word "might" is as I said
> > > above.
> >
> > Not a very compelling case for changing the kernel rather than getting
> > GCC fixed.
> >
> 
> I think we are misunderstanding eachother. Or rather, I seem to have
> misread what Nix wrote.
> 
> I saw  "(i.e., there's a reason that warning uses the word *might*.)"
> and mistakenly read it as a question - "is there a reason that warning
> uses the word *might*?".
> I then proceeded to answer that question.
> When I read your latest mail I then couldn't make sense of things any
> longer and went back and read the previous mails again and realized my
> mistake.
> 
> My bad, sorry.

I went hunting for this in the GCC bugzilla, and one bug basically said.
"Yeah, we know the initialization checking code doesn't work right, but
 fixing it is too hard"
