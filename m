Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbTESKsa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 06:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262383AbTESKsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 06:48:30 -0400
Received: from unthought.net ([212.97.129.24]:51350 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S262382AbTESKs2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 06:48:28 -0400
Date: Mon, 19 May 2003 13:01:23 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Dean McEwan <dean_mcewan@linuxmail.org>
Cc: szepe@pinerecords.com, viro@parcelfarce.linux.theplanet.co.uk,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Digital Rights Management - An idea (limited lease, renting, expiration, verification) NON HAR*D*WARE BASED.
Message-ID: <20030519110122.GC14971@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Dean McEwan <dean_mcewan@linuxmail.org>, szepe@pinerecords.com,
	viro@parcelfarce.linux.theplanet.co.uk, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org
References: <20030515104458.4886.qmail@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030515104458.4886.qmail@linuxmail.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 10:44:58AM +0000, Dean McEwan wrote:
> Actually the program is dynamically encrypted with a new key each time.

Yeah, whatever

> Intefering with memory buffers causes the kernel to delete the
> program, Key is sent over VPN, tampering with the kernel causes the
> MD5 hash to be incorrect,

Who sends the now-incorrect MD5?  The kernel? But since it's been
tampered with, how do you know it sends the trust now-incorrect MD5 sum,
instead of a copy of the original MD5 sum?

> and key isn't sent, DRM self scans itself,

What for?

If DRM is tampered with, making it scan itself is pretty useless - once
it has been tampered with, it can no longer be trusted to perform the
self scan.   In other words, such self-scanning is fundamentally flawed.

Read "The inevitability of failure" - pay special attention to the fact
that they *never* recommend anything like self-scanning, but rather
focus on mechanisms to ensure that whatever it was you wanted to
self-scan could never have been tampered with in the first place (thus
making the self-scanning that can't work anyway, a non-issue).

  http://www.nsa.gov/selinux/inevit-abs.html

> MD5 hash sums are made on the sources and DRM will dynamically
> recompile itself every 32 seconds, checking the sources.

... using which compiler ?

... compiled using which compiler ?

Nevermind that - you don't need to answer.

Read "Reflections on trusting trust" by Ken R.

   http://cm.bell-labs.com/who/ken/trust.html


Your idea is fundamentally flawed. You can always add more layers of
self-checking-self-checkers, but this does not change the fact that the
idea is fundamentally flawed.

I'm sorry - it's not that I don't like you or anything like that - but
the idea is stupid, just give it up   :)

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
