Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262481AbSJKOJk>; Fri, 11 Oct 2002 10:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262484AbSJKOJj>; Fri, 11 Oct 2002 10:09:39 -0400
Received: from users.linvision.com ([62.58.92.114]:48282 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S262481AbSJKOJX>; Fri, 11 Oct 2002 10:09:23 -0400
Date: Fri, 11 Oct 2002 16:14:54 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Larry McVoy <lm@work.bitmover.com>, Jeff Garzik <jgarzik@pobox.com>,
       Walter Landry <wlandry@ucsd.edu>, linux-kernel@vger.kernel.org
Subject: Re: A simple request (was Re: boring BK stats)
Message-ID: <20021011161454.C345@bitwizard.nl>
References: <20021009.163920.85414652.wlandry@ucsd.edu> <3DA58B60.1010101@pobox.com> <20021010072818.F27122@work.bitmover.com> <20021011153538.A345@bitwizard.nl> <20021011160828.B345@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021011160828.B345@bitwizard.nl>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2002 at 04:08:28PM +0200, Rogier Wolff wrote:
> Jeff: 
> 
> The trick is that I would have hardlinked trees. Thus 
> 
> 	linux-2.2.18.clean/drivers/char/tty_ioctl.c
> and
> 	linux-2.2.18.rio/drivers/char/tty_ioctl.c
> 
> would have the same inode number, and diff wouldn't even bother to
> open the file.... 

FYI: 

Just tested the how long it takes to make a diff between my
2.2.18-clean tree and the 2.2.18.rio tree:

cold cache over NFS:     25 seconds
warm cache over NFS:     13 seconds
warm cache LOCAL disk:    0.34 seconds. 

					Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currenly in such an       * 
* excursion: The stable situation does not include humans. ***************
