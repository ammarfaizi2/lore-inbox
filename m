Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284913AbRL3U1X>; Sun, 30 Dec 2001 15:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284871AbRL3U1N>; Sun, 30 Dec 2001 15:27:13 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12563 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S284765AbRL3U1C>; Sun, 30 Dec 2001 15:27:02 -0500
Date: Sun, 30 Dec 2001 20:26:55 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bogus devfs ChangeLog change in 2.5.2-pre4
Message-ID: <20011230202655.E9625@flint.arm.linux.org.uk>
In-Reply-To: <200112302014.fBUKEJM29085@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200112302014.fBUKEJM29085@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Sun, Dec 30, 2001 at 01:14:19PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2001 at 01:14:19PM -0700, Richard Gooch wrote:
>   Hi, Linus. Someone sneaked the appended patch into 2.5.2-pre4, which
> is not necessary and obviously wrong (the ChangeLog was correct
> previously). Please revert.
> 
> Looks like the result of an automated global search-and-replace
> (i.e. lazy cleanup). Pity a sanity a last-minute sanity check wasn't
> performed by the guilty party.
> </grumble>

That's not the only thing.  There's also a load of:

#else
#endif

constructs now as well that need cleaning up.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

