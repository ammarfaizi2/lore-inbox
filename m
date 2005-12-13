Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932599AbVLMSen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599AbVLMSen (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 13:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932597AbVLMSen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 13:34:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46523 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932594AbVLMSem (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 13:34:42 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20051213094053.33284360.pj@sgi.com> 
References: <20051213094053.33284360.pj@sgi.com>  <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu> <20051213090219.GA27857@infradead.org> <20051213093949.GC26097@elte.hu> <20051213100015.GA32194@elte.hu> 
To: Paul Jackson <pj@sgi.com>
Cc: Ingo Molnar <mingo@elte.hu>, hch@infradead.org, akpm@osdl.org,
       dhowells@redhat.com, torvalds@osdl.org, arjan@infradead.org,
       matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Tue, 13 Dec 2005 18:34:24 +0000
Message-ID: <6281.1134498864@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:

> It is usually too easy to produce a nearly correct script, and too
> difficult to produce an exactly right one, for all but serious sed or
> perl regex hackers.

I'd be especially impressed if you can get it to also analyse the context in
which the semaphore is used and determine whether or not it should be a
counting semaphore, a mutex or a completion. You can probably do this sort of
thing with Perl regexes... they seem to be terrifically[*] powerful.

 [*] and I mean that in the proper sense:-)

David
