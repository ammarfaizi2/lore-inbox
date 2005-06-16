Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbVFPCgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbVFPCgo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 22:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbVFPCgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 22:36:43 -0400
Received: from thunk.org ([69.25.196.29]:8864 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261707AbVFPCgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 22:36:37 -0400
Date: Wed, 15 Jun 2005 22:36:30 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Patrick McFarland <pmcfarland@downeast.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Alexey Zaytsev <alexey.zaytsev@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A Great Idea (tm) about reimplementing NLS.
Message-ID: <20050616023630.GC9773@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Patrick McFarland <pmcfarland@downeast.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Alexey Zaytsev <alexey.zaytsev@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <f192987705061303383f77c10c@mail.gmail.com> <f192987705061310202e2d9309@mail.gmail.com> <1118690448.13770.12.camel@localhost.localdomain> <200506152149.06367.pmcfarland@downeast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506152149.06367.pmcfarland@downeast.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2005 at 09:49:05PM -0400, Patrick McFarland wrote:
> On Monday 13 June 2005 03:20 pm, Alan Cox wrote:
> > An ext3fs is always utf-8. People might have chosen to put other
> > encodings on it but thats "not our fault" ;)
> 
> What happens if you 'field upgrade' ext2 to ext3 by adding a journal? That 
> doesn't magically convert !utf-8 to utf-8.

Ext2/3's encoding has always been utf-8.  Period.

There have been some people who have chosen to do something else
locally, but that was about as valid as the people who violated SMTP
standards by Just Sending 8-bits instead of using MIME.

							- Ted
