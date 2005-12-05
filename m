Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbVLEK4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbVLEK4W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 05:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbVLEK4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 05:56:21 -0500
Received: from gate.in-addr.de ([212.8.193.158]:29152 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S932368AbVLEK4V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 05:56:21 -0500
Date: Mon, 5 Dec 2005 11:55:36 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Willy Tarreau <willy@w.ods.org>, Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>,
       Matthias Andree <matthias.andree@gmx.de>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051205105536.GB5148@marowsky-bree.de>
References: <20051203135608.GJ31395@stusta.de> <9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com> <20051203201945.GA4182@kroah.com> <9a8748490512031948m26b04d3ds9fbc652893ead40@mail.gmail.com> <20051204115650.GA15577@merlin.emma.line.org> <20051204232454.GG8914@kroah.com> <20051205062609.GA7096@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051205062609.GA7096@alpha.home.local>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-12-05T07:26:09, Willy Tarreau <willy@w.ods.org> wrote:

> What I think should be done is to still maintain older 2.6
> (eg: 2, 3 or 4 previous releases) so that people will have
> the time to switch to a new one. And I think that what Adrian
> wants to do would be useful *only* if he proceeds that way.
>  
> Maybe you should just join forces, eg Chris and you to catch
> new patches, and Adrian to merge them to older kernels ? Every
> software maker always supports a few older releases for the
> people who need to stay on something stable, and it is clearly
> what is missing now in 2.6.

Well, this is probably the most useful suggestion so far. The kernel is
free land; if you or someone else wants to maintain the upcoming 2.6.16
"forever", and backport fixes or selected features, by all means, do it.
Define your policy, set up a tree, and off you go.

If Adrian will maintain it, it'll for sure be the most static kernel
ever.

This won't impact the Linux kernel, which will just continue to run its
course. The kernel process as a whole doesn't need to change; just
someone needs to do the grunt work.

If your kernel is wildly successful and adopted by users as well as
distributions, you'll be very happy and tell us 'told ya so!'. If not,
no harm will be done either, and you'll have the kernel you want for
your own purposes.

Be aware however that this is a very painful job. Trust me, I've been
involved with the receiving end of maintaining such a kernel for SLES
for a couple of releases. ;-)

Which is exactly the point: it's so painful that for this, people want
to be paid, and don't like doing it in their spare time. You may
maintain it for 6 months, sure, which will be less painful than
maintaining it for 5, 7 years, but when you rebase, you'll still put
your users into the dependency hell, and they won't have tested the
intermediate releases... Ouch. Not to mention that not every backported
fix is trivial to do.

Anyway, good luck to you.

The current 2.6.x.y-stable series is quite sane, because they are
essentially just fixing very critical bugs in very recent kernels, with
little back porting effort.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

