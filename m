Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932619AbWAJUgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932619AbWAJUgc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 15:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932613AbWAJUgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 15:36:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9639 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932597AbWAJUga (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 15:36:30 -0500
Date: Tue, 10 Jan 2006 12:31:18 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
cc: "Brown, Len" <len.brown@intel.com>,
       "David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, git@vger.kernel.org
Subject: Re: git pull on Linux/ACPI release tree
In-Reply-To: <20060110201909.GB3911@stusta.de>
Message-ID: <Pine.LNX.4.64.0601101229390.4939@g5.osdl.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505@hdsmsx401.amr.corp.intel.com>
 <Pine.LNX.4.64.0601081111190.3169@g5.osdl.org> <20060108230611.GP3774@stusta.de>
 <Pine.LNX.4.64.0601081909250.3169@g5.osdl.org> <20060110201909.GB3911@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 Jan 2006, Adrian Bunk wrote:
> 
> > Now, in this model, you're not really using git as a distributed system. 
> > In this model, you're using git to track somebody elses tree, and track a 
> > few patches on top of it, and then "git rebase" is a way to move the base 
> > that you're tracking your patches against forwards..
> 
> I am using the workaround of carrying the patches in a mail folder, 
> applying them in a batch, and not pulling from your tree between 
> applying a batch of patches and you pulling from my tree.

Yes, that also works.

I think "quilt" is really the right thing here, although stg may be even 
easier due to the more direct git integration. But with a smallish number 
of patches, just doing patch management by hand is obviously simply not a 
huge problem either, so extra tools may just end up confusing the issue.

		Linus
