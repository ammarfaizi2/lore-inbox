Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262960AbUD2CUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbUD2CUl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 22:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262972AbUD2CUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 22:20:41 -0400
Received: from mail41-s.fg.online.no ([148.122.161.41]:58843 "EHLO
	mail41-s.fg.online.no") by vger.kernel.org with ESMTP
	id S262960AbUD2CUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 22:20:18 -0400
From: Kenneth =?iso-8859-1?q?Aafl=F8y?= <keaafloy@online.no>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Date: Thu, 29 Apr 2004 04:20:13 +0200
User-Agent: KMail/1.6.2
References: <Pine.LNX.4.44.0404281958310.19633-100000@chimarrao.boston.redhat.com> <40904EF5.7080903@yahoo.com.au>
In-Reply-To: <40904EF5.7080903@yahoo.com.au>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404290420.13976.keaafloy@online.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 April 2004 02:40, you wrote:
> Rik van Riel wrote:
> > On Wed, 28 Apr 2004, Marc Boucher wrote:
> >>At the same time, I think that the "community" should, without
> >>relinquishing its principles, be less eager before getting the facts to
> >>attack people and companies trying to help in good faith, and be more
> >>realistic when it comes to satisfying practical needs of ordinary
> >>users.
> >
> > I wouldn't be averse to changing the text the kernel prints
> > when loading a module with an incompatible license. If the
> > text "$MOD_FOO: module license '$BLAH' taints kernel." upsets
> > the users, it's easy enough to change it.
> >
> > How about the following?
> >
> > "Due to $MOD_FOO's license ($BLAH), the Linux kernel community
> > cannot resolve problems you may encounter. Please contact
> > $MODULE_VENDOR for support issues."
>
> I think something like that is much easier to decipher.

Why cannot the binary module suppliers tell their customers why this 'tainted' 
message is appearing in their kernel log?

You know they are human, and have a mind of their own, they would probably 
have understood the fact that the company is providing it's own set of 
drivers that might not be tested fully on every kernel release. And so their 
customers (like what nVidias and others companies customers have done in the 
past) would turn to this company for support instead of the lkml.

Kenneth
				does not need to state the fact that this is just 2 cents.
