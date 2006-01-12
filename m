Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbWALCWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbWALCWq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 21:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932678AbWALCWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 21:22:46 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:49551 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932483AbWALCWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 21:22:45 -0500
From: Junio C Hamano <junkio@cox.net>
To: "Sean" <seanlkml@sympatico.ca>
Subject: Re: Revised [PATCH] Documentation: Update to SubmittingPatches
References: <cbec11ac0512201343q79de6e13h6fccf1259445076@mail.gmail.com>
	<20060111005721.GA29663@stusta.de>
	<BAYC1-PASMTP11D76F1C8E40096264A62CAE240@CEZ.ICE>
cc: "Adrian Bunk" <bunk@stusta.de>, "Ian McDonald" <imcdnzl@gmail.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       trivial@kernel.org, "Andrew Morton" <akpm@osdl.org>,
       "Linus Torvalds" <torvalds@osdl.org>
Date: Wed, 11 Jan 2006 18:22:43 -0800
In-Reply-To: <BAYC1-PASMTP11D76F1C8E40096264A62CAE240@CEZ.ICE>
	(seanlkml@sympatico.ca's message of "Tue, 10 Jan 2006 20:38:23 -0500
	(EST)")
Message-ID: <7vu0cagp70.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Sean" <seanlkml@sympatico.ca> writes:

>> The average patch submitter does _not_ use git in any way - and there's
>> no reason why he should.
>
> Git is an efficient and convenient way to track the mainline kernel.   The
> number of submitters using it is significant enough to mention it as an
> option for creating patches.

I agree with Adrian on this point.  The
kernel-list patch reviewing process only depends on "diff -pu"
format, and git obviously gives its users an easy way to
generate such, but so would other tools.

The number of patches on the kernel list that are coming from
git does not really matter, but even if it did, they seem to be
a very small minority.

This is SubmittingPatches document that is being discussed, not
LinusPleasePull document.  The latter would naturally _require_
the developer to use git, but not the former.

