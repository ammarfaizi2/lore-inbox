Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbWAYXYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbWAYXYk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 18:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWAYXYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 18:24:39 -0500
Received: from outmail1.freedom2surf.net ([194.106.33.237]:60556 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S932223AbWAYXYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 18:24:36 -0500
Message-ID: <43D808EE.9040906@f2s.com>
Date: Wed, 25 Jan 2006 23:25:34 +0000
From: Ian Molton <spyro@f2s.com>
Organization: The Dragon Roost
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051219)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Akinobu Mita <mita@miraclelinux.com>, linux-kernel@vger.kernel.org,
       Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>, dev-etrax@axis.com,
       David Howells <dhowells@redhat.com>,
       Yoshinori Sato <ysato@users.sourceforge.jp>,
       Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
       Hirokazu Takata <takata@linux-m32r.org>, linux-m68k@vger.kernel.org,
       Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       linux390@de.ibm.com, linuxsh-dev@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
       Andi Kleen <ak@suse.de>, Chris Zankel <chris@zankel.net>
Subject: Re: [PATCH 3/6] C-language equivalents of include/asm-*/bitops.h
References: <20060125112625.GA18584@miraclelinux.com> <20060125113206.GD18584@miraclelinux.com> <20060125200250.GA26443@flint.arm.linux.org.uk>
In-Reply-To: <20060125200250.GA26443@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

> This code generates more expensive shifts than our (ARMs) existing C
> version.  This is a backward step.
> 
> Basically, shifts which depend on a variable are more expensive than
> constant-based shifts.

arm26 will have the same problem here.

