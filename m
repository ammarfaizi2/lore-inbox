Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbVARWYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbVARWYQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 17:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbVARWYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 17:24:16 -0500
Received: from lea.cs.unibo.it ([130.136.1.101]:15596 "EHLO lea.cs.unibo.it")
	by vger.kernel.org with ESMTP id S261452AbVARWX5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 17:23:57 -0500
Date: Tue, 18 Jan 2005 23:23:51 +0100
From: Luca Ferroni <fferroni@cs.unibo.it>
To: linux-kernel@vger.kernel.org
Subject: Re: [fuse-devel] Merging?
Message-Id: <20050118232351.3770b001.fferroni@cs.unibo.it>
In-Reply-To: <20050112110109.6a21fae5.akpm@osdl.org>
References: <loom.20041231T155940-548@post.gmane.org>
	<E1ClQi2-0004BO-00@dorka.pomaz.szeredi.hu>
	<E1CoisR-0001Hi-00@dorka.pomaz.szeredi.hu>
	<20050112110109.6a21fae5.akpm@osdl.org>
Organization: Ferrlabs
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Wed, 12 Jan 2005 11:01:09 -0800,  Andrew Morton <akpm@osdl.org> ha scritto:

> Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> >  Well, there doesn't seem to be a great rush to include FUSE in the
> >  kernel.  Maybe they just don't realize what they are missing out on ;)
> 
> heh.  What userspace filesystems have thus-far been developed, and what are
> people using them for?

For my master laurea thesis I developed PackageFS that aims to 
transparently manage packages in several distros.
There are also many other facilities:
- View a directory-based tree of packages (with the files that each package owns)
which can be nested by category, or by priority

In the future
- you will be able to add users to "packages" group to make them able 
to manage packages
- you can mount the file system on a cluster to transparently manage
several hosts

You can find my thesis at http://packagefs.sourceforge.net

I think FUSE is a very good idea (as good as the actual implementation is),
IMHO it should be inserted in the mainline kernel.
Thanks to Miklos and other developers. 

Luca
-- 
Non ci toglieranno mai....la LIBERTA'!!!
Luca Ferroni
ICQ #317977679
www.cs.unibo.it/~fferroni/
