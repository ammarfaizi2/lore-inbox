Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbVALUaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVALUaT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 15:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbVALUaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 15:30:08 -0500
Received: from adsl-298.mirage.euroweb.hu ([193.226.239.42]:17284 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261381AbVALU3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 15:29:06 -0500
To: akpm@osdl.org
CC: kinema@gmail.com, fuse-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
In-reply-to: <20050112110109.6a21fae5.akpm@osdl.org> (message from Andrew
	Morton on Wed, 12 Jan 2005 11:01:09 -0800)
Subject: Re: [fuse-devel] Merging?
References: <loom.20041231T155940-548@post.gmane.org>
	<E1ClQi2-0004BO-00@dorka.pomaz.szeredi.hu>
	<E1CoisR-0001Hi-00@dorka.pomaz.szeredi.hu> <20050112110109.6a21fae5.akpm@osdl.org>
Message-Id: <E1CooxV-0002Xn-00@localhost>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 12 Jan 2005 21:19:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  Well, there doesn't seem to be a great rush to include FUSE in the
> >  kernel.  Maybe they just don't realize what they are missing out on ;)
> 
> heh.  What userspace filesystems have thus-far been developed, and what are
> people using them for?

Sshfs (idea shamelessly stolen from the LUFS project).  If you can ssh
to some host you can also mount it as a normal user like this:

   mkdir /tmp/kempelen
   sshfs mszeredi@kempelen: /tmp/kempelen

It pretty much trumps all other network filesystems wrt ease of server
setup, it's secure, efficient, all you need in a network filesystem :)

(available from http://sourceforge.net/projects/fuse; needs
fuse-2.2-pre3 and libglib-2.0)

Miklos
