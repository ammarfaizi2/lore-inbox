Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbTDZQQC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 12:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbTDZQQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 12:16:02 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1555 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261821AbTDZQQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 12:16:01 -0400
Date: Sat, 26 Apr 2003 09:29:07 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Zack Brown <zbrown@tumblerings.org>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ChangeLog suggestion
In-Reply-To: <20030426062105.GA1423@renegade>
Message-ID: <Pine.LNX.4.44.0304260924190.2276-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 25 Apr 2003, Zack Brown wrote:
> 
> I'm not familiar with your scripts, but I'd be surprised if this were very
> difficult to implement.

Well, the scripts can take it, but quite frankly I'd rather not clutter 
the changelogs up with crud that really doesn't matter.

The thing is, the stuff that already _is_ in the changelog is certainly 
enough to identify the email if you just have a reasonable search engine. 
You have author, comments and diff, and if that isn't enough to identify 
the thing then something is wrong.

Also, _most_ of the patches by far end up coming as personal emails, and
while they have often shown up on linux-kernel in _some_ way, it won't be
the same email that got sent to me. The email that showed up on the
mailing list will often have been of the type "please test this out and if
it works for you I'll send it to Linus", or it will have been posted by
the original author and then the actual patch made it to me either through
somebody elses BK tree _or_ through a person like Andrew Morton or Alan
Cox.

In other words, what you ask for is ugly (yes, I actually look at the 
output of "bk changes") _and_ not very useful.

			Linus

