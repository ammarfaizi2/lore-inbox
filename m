Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293224AbSCEO4G>; Tue, 5 Mar 2002 09:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293233AbSCEOz4>; Tue, 5 Mar 2002 09:55:56 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:57695 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S293224AbSCEOzp>; Tue, 5 Mar 2002 09:55:45 -0500
Date: Tue, 5 Mar 2002 15:55:56 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: arjan@fenrus.demon.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
Message-ID: <20020305155556.C20606@dualathlon.random>
In-Reply-To: <20020305005215.U20606@dualathlon.random> <200203050835.g258ZpW25134@fenrus.demon.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200203050835.g258ZpW25134@fenrus.demon.nl>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2002 at 08:35:51AM +0000, arjan@fenrus.demon.nl wrote:
> In article <20020305005215.U20606@dualathlon.random> you wrote:
> 
> > I don't see how per-zone lru lists are related to the kswapd deadlock.
> > as soon as the ZONE_DMA will be filled with filedescriptors or with
> > pagetables (or whatever non pageable/shrinkable kernel datastructure you
> > prefer) kswapd will go mad without classzone, period.
> 
> So does it with class zone on a scsi system....

as said in another message such pool isn't refilled in a flood.

Andrea
