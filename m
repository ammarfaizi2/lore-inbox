Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030326AbVKCDvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030326AbVKCDvT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 22:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030328AbVKCDvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 22:51:19 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:48597
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1030326AbVKCDvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 22:51:18 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: linux@horizon.com
Subject: Re: Would I be violating the GPL?
Date: Wed, 2 Nov 2005 21:50:29 -0600
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, s0348365@sms.ed.ac.uk
References: <20051102222109.16639.qmail@science.horizon.com>
In-Reply-To: <20051102222109.16639.qmail@science.horizon.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511022150.29448.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 November 2005 16:21, linux@horizon.com wrote:
> Amongst the various arguments here for declaring a binary kernel
> module a drived work based on including kernel headers, please
> take a step back and remember that what's sauce for the goose is
> sauce for the gander.

I think we've noticed the past few years of foaming looney attacks from SCO, 
yes.  And Microsoft's own attempts to license its header files, and such.

> The basic question is, does the user of the headers require the permission
> of the author of the headers to distribute the resultant object code?
> If the answer is "no", then the question of the terms of that permission
> (the GNU GPL or otherwise) doesn't arise.

Are you creating your source code based on somebody else's source code, or are 
you creating your source code based on something else (documentation, a 
defined API, etc).

Whether or not you include the header files is a relatively minor issue, 
really.

> Suppose EvilCo produces an EvilOS and provides a series of headers for
> interfacing to EvilOS.

Been there, done that, watched it spawn groklaw.

> Now, if I write a piece of software that runs on EvilOS, or even a
> device driver to connect some hardware to EvilOS, do I want to need
> EvilCo's permission to distribute a percompiled version?

Ask Microsoft.  They were flirting with this kind of thing years ago.  (Trying 
to make it so that their development tools couldn't be used to create open 
source.)  This effort was about as widely ignored as their shrinkwrap license 
terms from the 1980's.

> Do I want 
> them to claim proprietary rights in the source code because it refers
> to symbols defined in their headers?

Are those symbols documented?  Or did they have to deeply study a copyrighted 
work in that claims rights over derived works in order to find out about 
those symbols in the first place?

> (There is a bit of that in the game console market, but that's enforced by
> not giving you the headers until you agree to an NDA with lots of
> conditions.)

There's a difference between grounds for a lawsuit and a slam-dunk easy case 
you're confident you can win in a finite amount of time.  If you're trying to 
prevent Foaming Nutballs, Inc. from ever having the slightest trumped up 
grounds for a suit, you're not going to be doing much.

> In particular, it's a lot harder to argue that such a claim is ridiculous
> if you're making the same claim yourself.  And it's not at all clear to me
> that the benefit is worth that cost.

I don't think anybody with a brain is arguing that #including the userspace 
(/usr/include) header files puts your Linux program under the GPL.  And 
there's never been any alternative but to include the GPL linux kernel header 
files in those...

> Feel free to argue that the cost is worth it; what worried me was that it
> wasn't clear that people were considering the flip side of the arguments
> at all.  (Of course, there are a lot more mailing list archives than I've
> read; I may just have missed it.)

I've been considering the flip side of all these arguments for about five 
years, and considering them especially closely for the last two. :)

Rob
