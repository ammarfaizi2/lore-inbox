Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbVABUei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVABUei (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 15:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVABUei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 15:34:38 -0500
Received: from mail1.kontent.de ([81.88.34.36]:27343 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261322AbVABUd6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 15:33:58 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: the umount() saga for regular linux desktop users
Date: Sun, 2 Jan 2005 21:34:16 +0100
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@ucw.cz>, luto@myrealbox.com, aebr@win.tue.nl,
       linux-kernel@vger.kernel.org
References: <20050102193724.GA18136@elf.ucw.cz> <20050102201147.GB4183@stusta.de>
In-Reply-To: <20050102201147.GB4183@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501022134.16338.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 2. Januar 2005 21:11 schrieb Adrian Bunk:
> On Sun, Jan 02, 2005 at 08:37:24PM +0100, Pavel Machek wrote:
> 
> > Well, umount -l can be handy, but it does not allow you to get your CD
> > back from the drive.
> > 
> > umount --kill that kills whoever is responsible for filesystem being
> > busy would solve part of the problem (that can be done in userspace,
> > today).
> >...
> 
> What's wrong with
> 
>   fuser -k /mnt && umount /mnt

1. Would need suid.
2. Is a mindless slaughter of important processes.
3. Is a race condition.

	Regards
			Oliver
