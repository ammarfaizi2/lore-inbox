Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbVIJOP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbVIJOP3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 10:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750928AbVIJOP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 10:15:29 -0400
Received: from smtp06.auna.com ([62.81.186.16]:51639 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S1750917AbVIJOP2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 10:15:28 -0400
Date: Sat, 10 Sep 2005 14:15:28 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: [GIT PATCH] Remove devfs from 2.6.13
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20050909214542.GA29200@kroah.com>
In-Reply-To: <20050909214542.GA29200@kroah.com> (from gregkh@suse.de on Fri
	Sep  9 23:45:42 2005)
X-Mailer: Balsa 2.3.4
Message-Id: <1126361728l.7832l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.208.222] Login:jamagallon@able.es Fecha:Sat, 10 Sep 2005 16:15:26 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 09.09, Greg KH wrote:
> Here are the same "delete devfs" patches that I submitted for 2.6.12.
> It rips out all of devfs from the kernel and ends up saving a lot of
> space.  Since 2.6.13 came out, I have seen no complaints about the fact
> that devfs was not able to be enabled anymore, and in fact, a lot of
> different subsystems have already been deleting devfs support for a
> while now, with apparently no complaints (due to the lack of users.)
> 
> I mean, how can you go wrong with deleting over 8000 lines of kernel
> code :)
> 
> So, please pull from:
> 
> Please pull from:
> 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/devfs-2.6.git/
> or if master.kernel.org hasn't synced up yet:
> 	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/devfs-2.6.git/
> 
> I've posted all of these patches before, but if people really want to look at them, they can be found at:
> 	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-05-devfs/
> 
> Also, if people _really_ are in love with the idea of an in-kernel
> devfs, I have posted a patch that does this in about 300 lines of code,
> called ndevfs.  It is available in the archives if anyone wants to use
> that instead (it is quite easy to maintain that patch outside of the
> kernel tree, due to it only needing 3 hooks into the main kernel tree.)
> 

I've been running kernel.org kernels on Mandrake since eons ago, and
since many time without devfs, just with static /dev or with udev.
I still have to find an application that has a devfs path hardcoded or
even as default, everything is like /dev/dvd, not /dev/ide/0/7/disk3...
Everythig works: sound, net, etc.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.13-jam3 (gcc 4.0.1 (4.0.1-5mdk for Mandriva Linux release 2006.0))


