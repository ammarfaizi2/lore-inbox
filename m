Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750901AbVJ3UYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbVJ3UYa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 15:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbVJ3UYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 15:24:30 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:40336
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1750838AbVJ3UYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 15:24:30 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Jeff Dike <jdike@addtoit.com>
Subject: Re: What's wrong with tmpfs?
Date: Sun, 30 Oct 2005 14:24:08 -0600
User-Agent: KMail/1.8
Cc: jonathan@jonmasters.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
References: <200510300624.38794.rob@landley.net> <35fb2e590510300453q520a9ce7ua1d74d7790b3a6b8@mail.gmail.com> <20051030151506.GA3354@ccure.user-mode-linux.org>
In-Reply-To: <20051030151506.GA3354@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200510301424.09100.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 October 2005 09:15, Jeff Dike wrote:
> On Sun, Oct 30, 2005 at 12:53:00PM +0000, Jon Masters wrote:
> > On 10/30/05, Rob Landley <rob@landley.net> wrote:
> > > If somebody needs a reproduction sequence, I'm happy to oblige.  In
> > > theory "mount -t tmpfs /mnt /mnt" should do it, but if it was _that_
> > > simple it wouldn't have shipped...
> >
> > I don't see this behaviour on a regular desktop box running 2.6.14.
> > Guess it's UML specific.
>
> Sorry, but wrong.
>
> IIRC, this triggers when you don't have CONFIG_TMPFS enabled.  If you
> don't, you still get it, but you get a version that's only usable
> in-kernel.

Yup.  Not CONFIG_TEMPFS.  My bad.

Rob
