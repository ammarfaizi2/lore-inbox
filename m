Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264125AbTH1SPS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 14:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264116AbTH1SPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 14:15:18 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:26320 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP id S264125AbTH1SPJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 14:15:09 -0400
From: root@mauve.demon.co.uk
Message-Id: <200308281810.TAA24356@mauve.demon.co.uk>
Subject: Re: Lockless file reading
To: jamie@shareable.org (Jamie Lokier)
Date: Thu, 28 Aug 2003 19:10:05 +0100 (BST)
Cc: root@mauve.demon.co.uk, ragnar@linalco.com (Ragnar Hojland Espinosa),
       davids@webmaster.com (David Schwartz), tss@iki.fi (Timo Sirainen),
       linux-kernel@vger.kernel.org
In-Reply-To: <20030828173522.GA8581@mail.jlokier.co.uk> from "Jamie Lokier" at Aug 28, 2003 06:35:22 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> root@mauve.demon.co.uk wrote:
> > > Probability on the order of 2^-32 with MD5 any-pairs collision.
> > MD5 is 128 bit output, so that's around 2^64 pairs before you have a birthday.
> 
> Right.  Dozy me :)
> 
> > > Do you still have the GIFs?
> > 
> > There arn't that many GIFs in the world.
> > I'd be really surprised if there were that many pictures in the world.
> 
> I'd be really surprised if what you saw wasn't a software error,
> misreporting or miscalculating the MD5.

Or perhaps more likely, truncating the hash to 32 bits, in which case for most
people there won't be a problem, as a collision isn't likely until you get
to tens of thousands of images.

