Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751044AbWCZNoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbWCZNoL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 08:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWCZNoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 08:44:11 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:15885 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1751044AbWCZNoK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 08:44:10 -0500
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: linux-kernel@vger.kernel.org, rob@landley.net, mmazur@kernel.pl,
       llh-discuss@lists.pld-linux.org
Subject: Re: [RFC][PATCH 0/2] KABI example conversion and cleanup
References: <200603141619.36609.mmazur@kernel.pl>
	<200603231811.26546.mmazur@kernel.pl>
	<DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com>
	<200603241623.49861.rob@landley.net> <878xqzpl8g.fsf@hades.wkstn.nix>
	<D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com>
	<20060326065205.d691539c.mrmacman_g4@mac.com>
	<20060326070605.130a5a53.mrmacman_g4@mac.com>
From: Nix <nix@esperi.org.uk>
X-Emacs: because editing your files should be a traumatic experience.
Date: Sun, 26 Mar 2006 14:43:41 +0100
In-Reply-To: <20060326070605.130a5a53.mrmacman_g4@mac.com> (Kyle Moffett's
 message of "Sun, 26 Mar 2006 07:06:05 -0500")
Message-ID: <8764m12ueq.fsf@hades.wkstn.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Mar 2006, Kyle Moffett said:
> On Sun, 26 Mar 2006 06:52:05 -0500 Kyle Moffett <mrmacman_g4@mac.com> wrote:
>> 2)  Since most of the headers are currently quite broken with respect to
>>     GLIBC and userspace, I won't spend much extra time preserving
>>     compatibility with GLIBC, userspace, or non-GCC compilers.
> 
> That didn't come out right, but what I meant to say was this:  Since the 
> headers in include/linux are quite broken with respect to GLIBC and 
> userspace, I won't let so-called "compatibility" code like this get in 
> the way:

As long as the eventual goal is something that *works* with glibc and
uClibc and the rest of them, that's good enough as far as I can tell.
Obviously compatibility crud *in the headers* which serves no obvious
purpose and which userspace doesn't actually need should die (and
there's certainly some like that lying around).

-- 
`Come now, you should know that whenever you plan the duration of your
 unplanned downtime, you should add in padding for random management
 freakouts.'
