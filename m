Return-Path: <linux-kernel-owner+w=401wt.eu-S1755192AbWL3SWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755192AbWL3SWV (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 13:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755191AbWL3SWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 13:22:21 -0500
Received: from smtp.osdl.org ([65.172.181.25]:47548 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755188AbWL3SWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 13:22:20 -0500
Date: Sat, 30 Dec 2006 10:21:29 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all
 that again
In-Reply-To: <20061230163955.GA12622@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0612301021180.4473@woody.osdl.org>
References: <20061221152621.GB3958@flint.arm.linux.org.uk>
 <E1GxQF2-0000i6-00@dorka.pomaz.szeredi.hu> <20061221171739.GE3958@flint.arm.linux.org.uk>
 <20061230163955.GA12622@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Dec 2006, Russell King wrote:
>
> Given that no one has any outstanding issues with the following patch, I'm
> going to ask akpm to put this into -mm, and shortly after (a week or so)
> I'll submit it and the ARM flush_anon_page() patch to Linus for -rc to fix
> ARM data corruption issues.
> 
> If anyone _does_ have a problem, holler ASAP.

Looks fine to me. 

		Linus
