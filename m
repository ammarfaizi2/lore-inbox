Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWBRQks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWBRQks (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 11:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbWBRQks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 11:40:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38550 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932070AbWBRQkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 11:40:47 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060218022026.348e3b39.akpm@osdl.org> 
References: <20060218022026.348e3b39.akpm@osdl.org>  <8396.1140188581@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Keys: Deal properly with strnlen_user() 
X-Mailer: MH-E 7.91+cvs; nmh 1.1; GNU Emacs 22.0.50.1
Date: Sat, 18 Feb 2006 16:40:31 +0000
Message-ID: <3386.1140280831@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> ug.  Well it's your code ;)

Yeah...

> It should really parameterise `ret' too.
> 
> Are you sure you want to do this?  From my reading, doing it with plain old
> subroutines would work?

That complicates the error handling and potentially produces less optimal
code:-/

I think bringing it together though is definitely the right thing to do: fewer
bits to fix and all that.

Davud
