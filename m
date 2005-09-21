Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbVIUPoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbVIUPoR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 11:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbVIUPoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 11:44:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6559 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751099AbVIUPoQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 11:44:16 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0509210803310.2553@g5.osdl.org> 
References: <Pine.LNX.4.58.0509210803310.2553@g5.osdl.org>  <5378.1127211442@warthog.cambridge.redhat.com> <12434.1127314090@warthog.cambridge.redhat.com> 
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, akpm@osdl.org, keyrings@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Keys: Add possessor permissions to keys 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Wed, 21 Sep 2005 16:44:04 +0100
Message-ID: <17063.1127317444@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:

> Ok, maybe I'm just strange, but when I see code like
> 
> 	if (is_key_possessed(keyref)) {
> 
> I'm inevitably mentally going "Linda Blair! It is spewing pea-soup and
> rotating its head!"
> 
> Maybe not the best of naming practices..

Or maybe not the best of mental or film watching practices? :-)

How about if I call it is_key_retained() instead?

Of course, I now prefer the name is_key_possessed() if only to frighten other
kernel developers...

David
