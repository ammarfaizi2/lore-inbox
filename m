Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262294AbVCBN7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbVCBN7g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 08:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262295AbVCBN7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 08:59:36 -0500
Received: from smtp.cs.aau.dk ([130.225.194.6]:27786 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S262294AbVCBN7d convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 08:59:33 -0500
From: Kristian =?iso-8859-1?q?S=F8rensen?= <ks@cs.aau.dk>
Organization: Aalborg University
To: Christophe Lucas <clucas@rotomalug.org>
Subject: Re: UserMode bug in 2.6.11-rc5? autolearn=disabled version=3.0.2
Date: Wed, 2 Mar 2005 14:59:39 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <200503021236.26561.ks@cs.aau.dk> <20050302134533.GE13075@rhum.iomeda.fr>
In-Reply-To: <20050302134533.GE13075@rhum.iomeda.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503021459.39846.ks@cs.aau.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 March 2005 14:45, Christophe Lucas wrote:
> Kristian Sørensen (ks@cs.aau.dk) wrote:
> > Hi!
> >
> > I've just tried usermode Linux with a 2.6.11-rc5 kernel. My kernel boots,
> > but when the shell is to be spawned it freezes:
> > ----
> > INIT: Entering runlevel: 2
> > Starting system log daemon: syslogd.
> > Starting kernel log daemon: klogd.
> > Starting internet superserver: inetd.
> > Starting deferred execution scheduler: atd.
> > Starting periodic command scheduler: cron.
> > INIT: Id "0" respawning too fast: disabled for 5 minutes
> > INIT: Id "1" respawning too fast: disabled for 5 minutes
> > INIT: Id "2" respawning too fast: disabled for 5 minutes
> > INIT: Id "c" respawning too fast: disabled for 5 minutes
> > INIT: no more processes left in this runlevel
> > ----
> >
> > I've attached the .config for both 2.6.10 (working perfectly) and the one
> > for 2.6.11-rc5. The root filesystem this:
> > http://prdownloads.sourceforge.net/user-mode-linux/Debian-3.0r0.ext2.bz2
>
> Hi,
>
> What do you have in your /etc/inittab of your root_fs ?
> I think you sould replace tty0 by vc/0 such as.
>
> I have had this on a kernel 2.6.10 and debian-3.1 root_fs.
>
> 	~Christophe
Hey! Thanks - that fixed the problem! :-D


Best,
Kristian.


-- 
Kristian Sørensen
- The Umbrella Project  --  Security for Consumer Electronics
  http://umbrella.sourceforge.net

E-mail: ipqw@users.sf.net, Phone: +45 29723816
