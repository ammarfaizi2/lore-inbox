Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267033AbTBCXtQ>; Mon, 3 Feb 2003 18:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267034AbTBCXtQ>; Mon, 3 Feb 2003 18:49:16 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:10156 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S267033AbTBCXtQ>; Mon, 3 Feb 2003 18:49:16 -0500
From: David Woodhouse <dwmw2@infradead.org>
To: jt@hpl.hp.com
Cc: Andi Kleen <ak@suse.de>, Mikael Pettersson <mikpe@csd.uu.se>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
In-Reply-To: <20030203231740.GA29267@bougret.hpl.hp.com>
References: <20030124193721.GA24876@wotan.suse.de>
	<15926.60767.451098.218188@harpo.it.uu.se>
	<20030128212753.GA29191@wotan.suse.de>
	<15927.62893.336010.363817@harpo.it.uu.se>
	<20030129162824.GA4773@wotan.suse.de>
	<15934.49235.619101.789799@harpo.it.uu.se>
	<20030203194923.GA27997@bougret.hpl.hp.com>
	<20030203201255.GA32689@wotan.suse.de>
	<20030203214325.GA28330@bougret.hpl.hp.com>
	<20030203224619.GA6405@wotan.suse.de> 
	<20030203231740.GA29267@bougret.hpl.hp.com>
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Feb 2003 23:58:40 +0000
Message-Id: <1044316720.28406.58.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Subject: Re: 32bit emulation of wireless ioctls
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-03 at 23:17, Jean Tourrilhes wrote:
> 	<Puzzled of why you would *not* want a 64 bit userland>

Because 64-bit can be just a waste of space for no real gain, and more
to the point because some of the early SPARC64 chips are so broken that
if you let users run 64-bit code they can kill the box, so it's strictly
32-bit userland only on those.

-- 
dwmw2

