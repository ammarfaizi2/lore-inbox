Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285457AbRLNTAD>; Fri, 14 Dec 2001 14:00:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285459AbRLNS7y>; Fri, 14 Dec 2001 13:59:54 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:54087 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S285457AbRLNS7i>; Fri, 14 Dec 2001 13:59:38 -0500
Date: Fri, 14 Dec 2001 19:58:16 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: root <root@norma.kjist.ac.kr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Final link failure 2.4.17-rc1aa1
Message-ID: <20011214195816.J2431@athlon.random>
In-Reply-To: <200112141837.fBEIb2J07182@norma.kjist.ac.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <200112141837.fBEIb2J07182@norma.kjist.ac.kr>; from root@norma.kjist.ac.kr on Sat, Dec 15, 2001 at 03:37:02AM +0900
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2001 at 03:37:02AM +0900, root wrote:
> CONFIG_DISCONTIGMEM=y

discontigmem makes sense only with wildfire. Can you try to disable it?

I guess the problem is discontigmem enabled and numba disabled, I think
I always tested with either both enabled or both disabled...

dp264+discontimem+numa is supposed to work in a "emulated mode", but
really both discontigmem and numa at the moment should depend on
config_wildfire.

Andrea
