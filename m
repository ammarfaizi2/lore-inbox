Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262621AbTCTVhP>; Thu, 20 Mar 2003 16:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262623AbTCTVhP>; Thu, 20 Mar 2003 16:37:15 -0500
Received: from cygnus-ext.enyo.de ([212.9.189.162]:21254 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id <S262621AbTCTVhN>;
	Thu, 20 Mar 2003 16:37:13 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Release of 2.4.21
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Thu, 20 Mar 2003 22:48:13 +0100
In-Reply-To: <20030320211011$5967@gated-at.bofh.it> (Jeff Garzik's message
 of "Thu, 20 Mar 2003 22:10:11 +0100")
Message-ID: <87of45emle.fsf@deneb.enyo.de>
User-Agent: Gnus/5.090016 (Oort Gnus v0.16) Emacs/21.2 (gnu/linux)
References: <20030320205011$1378@gated-at.bofh.it>
	<20030320205011$0acb@gated-at.bofh.it>
	<20030320205011$2c88@gated-at.bofh.it>
	<20030320211011$5967@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

> On Thu, Mar 20, 2003 at 09:43:01PM +0100, Florian Weimer wrote:
>> Releasing an official 2.4.21 with some fixes (and no new features) is
>> just a PR issue.  I've already seen people comparing the alleged IIS
>> bug (or this new IE hole) and the ptrace() bug...
>
> Comparing, how?  There is no comparison.

You know it, I know it, our readers know it.  But the press puts them
on the same level nevertheless.

> This specific ptrace hole is closed, yay.  Now what about the other
> 10,001 that still exist?  People are blowing this ptrace bug WAY
> out of proportion.

I agree completely.  Local security on traditional UNIX-like systems
is *so* poor that this bug doesn't really matter.  No admin of a sane
mind lets untrusted users access important systems.

> The only reason why it demands a modicum of vendor responsibility is
> that a-holes are making easy-to-use exploits available for the
> script kiddies.

No, you miss a point.  These exploits are important to keep you kernel
developers honest.  Otherwise, you would have fixed this quitely, like
a couple of other bugs.  Admins would assume that kernels offered a
decent level of local security, which can lead to very questionable
decisions.
