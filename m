Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbVDJX1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbVDJX1k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 19:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbVDJX1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 19:27:03 -0400
Received: from fire.osdl.org ([65.172.181.4]:59334 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261653AbVDJXYT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 19:24:19 -0400
Date: Sun, 10 Apr 2005 16:26:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: New SCM and commit list
In-Reply-To: <1113174621.9517.509.camel@gaston>
Message-ID: <Pine.LNX.4.58.0504101621200.1267@ppc970.osdl.org>
References: <1113174621.9517.509.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Apr 2005, Benjamin Herrenschmidt wrote:
> 
> Do you intend to continue posting "commited" patches to a mailing list
> like bk scripts did to bk-commits-head@vger ? As I said a while ago, I
> find this very useful, especially with the actual patch included in the
> commit message (which isn't the case with most other projects CVS commit
> lists, and I find that annoying).

Absolutely. GIT isn't quite at the point where I can start using it yet,
though.

I could actually start committing patches, but I want to make sure that I
can also do automated simple merges, so that there is any _point_ to doing
this in the first place. My plan is to not be very good at merging (in 
particular, I don't see GIT resolving renames _at_all_), but my hope is 
that the people who used to merge with me using BK might be able to still 
do so using GIT, as long as we try actively to be very careful.

> If yes, then I would appreciate if you could either keep the same list,
> or if you want to change the list name, keep the subscriber list so
> those of us who actually archive it don't miss anything ;)

I didn't even set up the list. I think it's Bottomley. I'm cc'ing him just 
so that he sees the message, but I don't actually expect him to do 
anything about it. I'm not even ready to start _testing_ real merges yet. 
But I hope that I can get non-conflicting merges done fairly soon, and 
maybe I can con James or Jeff or somebody to try out GIT then...

			Linus
