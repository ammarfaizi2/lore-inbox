Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWACH15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWACH15 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 02:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWACH15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 02:27:57 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:7891 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751190AbWACH14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 02:27:56 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.15
Date: Tue, 03 Jan 2006 18:27:45 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <km9kr1ticuda2b003g50g6cnpqust54g8p@4ax.com>
References: <20060103050830.GA1134@kroah.com>
In-Reply-To: <20060103050830.GA1134@kroah.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jan 2006 21:08:30 -0800, Greg KH <gregkh@suse.de> wrote:

>Here are the same "delete devfs" patches that I submitted for 2.6.12 and
>2.6.13 and 2.6.14.  It rips out all of devfs from the kernel and ends up
>saving a lot of space.  Since 2.6.13 came out, I have seen no complaints
>about the fact that devfs was not able to be enabled anymore, and in
>fact, a lot of different subsystems have already been deleting devfs
>support for a while now, with apparently no complaints (due to the lack
>of users.)

me no use git user, so it was convert 'series' to a shell script ;)

patches applied with a few small offsets to 2.6.15

Noticed no difference on: 
  http://bugsplatter.mine.nu/test/linux-2.6/sempro/

Cheers,
Grant.
