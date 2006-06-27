Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWF0NNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWF0NNN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 09:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWF0NNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 09:13:13 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:39813 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932127AbWF0NNM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 09:13:12 -0400
Date: Tue, 27 Jun 2006 15:12:53 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org, klibc@zytor.com, torvalds@osdl.org
Subject: klibc and what's the next step?
In-Reply-To: <klibc.200606251757.00@tazenda.hos.anvin.org>
Message-ID: <Pine.LNX.4.64.0606271316220.17704@scrub.home>
References: <klibc.200606251757.00@tazenda.hos.anvin.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 25 Jun 2006, H. Peter Anvin wrote:

> The majority of the patches are independent in the sense that they
> should apply independently, but Makefile/Kbuild files may have to be
> adjusted to build a partially patched tree.

I could now repeat all the concerns I already mentioned, why it shouldn't 
be merged as is (that doesn't mean it shouldn't be merged at all!), but 
they have been pretty much ignored anyway...

What I'm more interested in is basically answering the question and where 
I hope to provoke a bit broader discussion: "What's next?"

Until recently for most developers klibc was not much more than a cool 
idea, but now we have the first incarnation and now we have to do a 
reality check of how it solves our problems. To say it drastically the 
current patch set as it is does not solve a single real problem yet, it 
only moves them from the kernel to kinit, which may be the first step but 
where to?

So what problems are we going to solve now and how? The amount of 
discussion so far is not exactly encouraging. If nobody cares, then there 
don't seem to be any real problems, so why should it be merged at all? Are 
shiny new features more important than functionality?

So anyone who likes to see klibc merged, because it will solve some kind 
of problem for him, please speak up now. Without this information it's 
hard to judge whether we're going to solve the right problems.

Peter, it would really help if you describe your own plans, how you want 
to go forward with it, otherwise it leaves a huge amount of uncertainty 
and since this is a rather big change, I think it's a real good idea to 
reduce this uncertainty, so we know what to expect and everyone can better 
evaluate how these changes will effect him. Right now these patches are 
devoid of any documentation, which make it hard for everyone to judge them 
(and what is IMO the main reason for the current uncomfortable silence).

Feel free to flame me now for making it so difficult, but I'm convinced 
it's better for everyone to make this step (even if it's the right one) 
with more information than we have right now...

bye, Roman
