Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265015AbRFUQHx>; Thu, 21 Jun 2001 12:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265018AbRFUQHn>; Thu, 21 Jun 2001 12:07:43 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:24582 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S265015AbRFUQHb>;
	Thu, 21 Jun 2001 12:07:31 -0400
Date: Thu, 21 Jun 2001 18:07:01 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: spindown
Message-ID: <20010621180701.B4523@pcep-jamie.cern.ch>
In-Reply-To: <20010615152306.B37@toy.ucw.cz> <20010618222131.A26018@paranoidfreak.co.uk> <20010619124627.A202@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010619124627.A202@bug.ucw.cz>; from pavel@suse.cz on Tue, Jun 19, 2001 at 12:46:27PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> > Isn't this why noflushd exists or is this an evil thing that shouldn't
> > ever be used and will eventually eat my disks for breakfast?
> 
> It would eat your flash for breakfast. You know, flash memories have
> no spinning parts, so there's nothing to spin down.

Btw Pavel, does noflushd work with 2.4.4?  The noflushd version 2.4 I
tried said it couldn't find some kernel process (kflushd?  I don't
remember) and that I should use bdflush.  The manual says that's
appropriate for older kernels, but not 2.4.4 surely.

-- Jamie
