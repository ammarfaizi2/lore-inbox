Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263496AbTEMWir (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 18:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263493AbTEMWiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 18:38:46 -0400
Received: from smtp.slac.stanford.edu ([134.79.18.80]:13021 "EHLO
	smtp.slac.stanford.edu") by vger.kernel.org with ESMTP
	id S263458AbTEMWil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 18:38:41 -0400
Date: Tue, 13 May 2003 15:51:26 -0700 (PDT)
From: Booker Bense <bbense@SLAC.Stanford.EDU>
Subject: Re: [OpenAFS-devel] Re: [PATCH] in-core AFS multiplexor and PAG support
In-reply-to: <Pine.LNX.4.53.0305131615440.12539@scully.trafford.dementia.org>
To: Derrick J Brashear <shadow@dementia.org>
Cc: David Howells <dhowells@cambridge.redhat.com>,
       Jan Harkes <jaharkes@cs.cmu.edu>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
Message-id: <Pine.LNX.4.55.0305131550310.7330@telemark.slac.stanford.edu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <9828.1052852002@warthog.warthog>
 <Pine.LNX.4.53.0305131615440.12539@scully.trafford.dementia.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 May 2003, Derrick J Brashear wrote:

> On Tue, 13 May 2003, David Howells wrote:
>
> > > >  (2) gettok(const char *fs, const char *key, size_t size, void *buffer)
> > > >
> > > >      Get a copy of an authentication token.
> > >
> > > Not sure what the use of this is for userspace. I can see how your
> > > kernel module would use it.
> >
> > OpenAFS has it, but I'm not sure what uses it.
>
> The simplest case: "List my tokens" (if you want any sort of detail about
> them). A program "tokens" does just this, lists all tokens you have, then
> enumerates with GetToken to get each and print some information about them
> (are they expired, for instance).
>
> There are also some debugging tools which can pull tokens back out and
> decode them using the server key, and some old primitive authentication
> passing stuff which is probably now all obsolete did also.
>

- It may be obsolete, but there are a lot of people using AFS
token passing in ssh.

_ Booker C. Bense
