Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263858AbTEGRDC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 13:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264118AbTEGRDC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 13:03:02 -0400
Received: from h-64-105-35-101.SNVACAID.covad.net ([64.105.35.101]:38825 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP id S263858AbTEGRCZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 13:02:25 -0400
Date: Wed, 7 May 2003 10:14:09 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200305071714.h47HE9u00434@freya.yggdrasil.com>
To: simon@thekelleys.org.uk
Subject: Re: Binary firmware in the kernel - licensing issues.
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I am not a lawyer, so please don't rely on this as legal advice.
I'm only explaining my layman's understanding.

Simon Kelley wrote:
>If many copyright holders don't agree then clearly firmware blobs
>shouldn't go into the kernel. It is difficult to argue that just one is
>enough for a veto [...]

	I don't think that should be difficult to argue.  Let's see.

	One objecting developer is enough for a lawsuit.  If a court
find copyright infringement and that developer registered the
copyright (a form TX from the copyright office and a $35 registration
fee, if memory serves), then I believe statutory damages would be
something like $750-30k per copy (see
http://www4.law.cornell.edu/uscode/17/504.html).  Theoretically,
there might be the potential for criminal prosecution of
for-profit distributors (see
http://www4.law.cornell.edu/uscode/18/2319.html).

	See how easy that was easy to argue?

>, especially since at least one driver (Advansys) has
>been there, complete with its "bucket of bits" since 1.3.x days at 
>least.

	This is the first I've heard of it.  In this case,
it appears that the copyright is GPL compatible, but it does
not appear that the GPL's requirement for the "preferred form of
the work for making modifications to it" has been satisfied
with respect to this binary blob of firmware.  If the source is
not included in the kernel, I think that binary blob should be
removed and replaced with some user level facility for loading that
array.  I wonder if it really is necessary to load the microcode
at all, as I would assume that there would have to be some
initial firmware loaded for the control to act as a boot
device (or can't it do that?).

>Any contributor to the kernel since then who cared could have 
>been aware of that as evidence of a de-facto interpretation of the GPL
>source clause as not applying to firmware in Linux.

	There are all sorts of obscure facts that one "could have
been aware" of, but that doesn't show that one _was_ aware of them
if you're trying to argue that one implicitly agreed to something.

>The technical advantages you give are not compelling for the Atmel 
>driver. The driver has international roaming support built-in and the
>firmware size is than 20k. In general though they may be good points.

>I suggest that having a driver which "just works" without needing
>extra files and configuration steps would trump minmizing legal
>exposure to the Linux copyright holders, for most people in the real
>world.

	It's not just the copyright holders who have the legal
exposure.  It would be anyone who distributes your driver.

	Again, I want to emphasize that I'm not a lawyer, and I
wouldn't want anyone to rely on my incomplete and potentially
quite incorrect layman's understanding as legal advice.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Miplitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
