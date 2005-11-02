Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751523AbVKBWVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbVKBWVL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 17:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965307AbVKBWVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 17:21:11 -0500
Received: from science.horizon.com ([192.35.100.1]:26676 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751523AbVKBWVK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 17:21:10 -0500
Date: 2 Nov 2005 17:21:09 -0500
Message-ID: <20051102222109.16639.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: Would I be violating the GPL?
Cc: s0348365@sms.ed.ac.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amongst the various arguments here for declaring a binary kernel
module a drived work based on including kernel headers, please
take a step back and remember that what's sauce for the goose is
sauce for the gander.

The basic question is, does the user of the headers require the permission
of the author of the headers to distribute the resultant object code?
If the answer is "no", then the question of the terms of that permission
(the GNU GPL or otherwise) doesn't arise.

I'd like to argue that people interested in free software should want
the answer to be "no", and should not try to establish precedents to
the contrary, and that asserting the claim could boomerang unpleasantly.

Suppose EvilCo produces an EvilOS and provides a series of headers for
interfacing to EvilOS.  Further suppose that EvilOS is not very good
about enforcing user/kernel separation and a lot of the headers describe
kernel-internal data structures that a user might nonetheless want to
hook into.

Now, if I write a piece of software that runs on EvilOS, or even a
device driver to connect some hardware to EvilOS, do I want to need
EvilCo's permission to distribute a percompiled version?  Do I want
them to claim proprietary rights in the source code because it refers
to symbols defined in their headers?

Or would I rather that such names and references are considered "Scenes
a faire" (standard boilerplate) for software that runs on EvilOS, and
as such not subject to copyright law?


Looking at all the crap companies are trying to impose about publishing
benchmarks, think before claiming that copyright law gives you some
authority, lest that claim be used against you.  I don't see such claims
being widely asserted by commercial companies, so I'm strongly disinclined
to try to start an arms race in that direction.

(There is a bit of that in the game console market, but that's enforced by
not giving you the headers until you agree to an NDA with lots of conditions.)

In particular, it's a lot harder to argue that such a claim is ridiculous
if you're making the same claim yourself.  And it's not at all clear to me
that the benefit is worth that cost.


Feel free to argue that the cost is worth it; what worried me was that it
wasn't clear that people were considering the flip side of the arguments
at all.  (Of course, there are a lot more mailing list archives than I've
read; I may just have missed it.)
