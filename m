Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbWACRy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbWACRy3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 12:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWACRy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 12:54:28 -0500
Received: from mail.kroah.org ([69.55.234.183]:21175 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932379AbWACRy1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 12:54:27 -0500
Date: Tue, 3 Jan 2006 09:54:00 -0800
From: Greg KH <gregkh@suse.de>
To: gcoady@gmail.com
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.15
Message-ID: <20060103175400.GB9445@suse.de>
References: <20060103050830.GA1134@kroah.com> <km9kr1ticuda2b003g50g6cnpqust54g8p@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <km9kr1ticuda2b003g50g6cnpqust54g8p@4ax.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2006 at 06:27:45PM +1100, Grant Coady wrote:
> On Mon, 2 Jan 2006 21:08:30 -0800, Greg KH <gregkh@suse.de> wrote:
> 
> >Here are the same "delete devfs" patches that I submitted for 2.6.12 and
> >2.6.13 and 2.6.14.  It rips out all of devfs from the kernel and ends up
> >saving a lot of space.  Since 2.6.13 came out, I have seen no complaints
> >about the fact that devfs was not able to be enabled anymore, and in
> >fact, a lot of different subsystems have already been deleting devfs
> >support for a while now, with apparently no complaints (due to the lack
> >of users.)
> 
> me no use git user, so it was convert 'series' to a shell script ;)
> 
> patches applied with a few small offsets to 2.6.15
> 
> Noticed no difference on: 
>   http://bugsplatter.mine.nu/test/linux-2.6/sempro/

Great, thanks for testing, I appreciate it.

greg k-h
