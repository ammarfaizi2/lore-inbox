Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312798AbSDFUan>; Sat, 6 Apr 2002 15:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312799AbSDFUam>; Sat, 6 Apr 2002 15:30:42 -0500
Received: from tele-post-20.mail.demon.net ([194.217.242.20]:21521 "EHLO
	tele-post-20.mail.demon.net") by vger.kernel.org with ESMTP
	id <S312798AbSDFUam>; Sat, 6 Apr 2002 15:30:42 -0500
Date: Sat, 6 Apr 2002 21:30:36 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre5-ac3: unresolved in radeonfb
Message-ID: <20020406203036.GA503@berserk.demon.co.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <200204051945.g35JjnX23183@devserv.devel.redhat.com> <3CAE3608.8DDE18EB@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Peter Horton <pdh@berserk.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 06, 2002 at 09:40:56AM +1000, Eyal Lebedinsky wrote:
> Alan Cox wrote:
> > Linux 2.4.19pre5-ac3
> > o       Small fix for the radeonfb                      (Peter Horton)
> 
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.19-pre5-ac3/kernel/drivers/video/radeonfb.o
> depmod:         radeon_engine_init_var
> 
> I could not find this symbol in the tree.
> 

Darn - I'm not very good at this :-(

Change the call to radeon_engine_init_var() to

	radeon_engine_init(rinfo);

P.
