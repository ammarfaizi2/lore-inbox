Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262291AbVCBNp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbVCBNp1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 08:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbVCBNp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 08:45:26 -0500
Received: from smtp4.wanadoo.fr ([193.252.22.27]:8041 "EHLO smtp4.wanadoo.fr")
	by vger.kernel.org with ESMTP id S262291AbVCBNpT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 08:45:19 -0500
X-ME-UUID: 20050302134518557.881FD1C00363@mwinf0407.wanadoo.fr
Date: Wed, 2 Mar 2005 14:45:33 +0100
From: Christophe Lucas <clucas@rotomalug.org>
To: Kristian =?iso-8859-1?Q?S=F8rensen?= <ks@cs.aau.dk>
Cc: linux-kernel@vger.kernel.org
Message-ID: <20050302134533.GE13075@rhum.iomeda.fr>
References: <200503021236.26561.ks@cs.aau.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200503021236.26561.ks@cs.aau.dk>
X-Operating-System: Debian GNU/Linux / 2.6.9 (i686)
X-Homepage: http://odie.mcom.fr/~clucas/
X-Crypto: GnuPG/1.2.4 http://www.gnupg.org
X-GPG-Key: http://odie.mcom.fr/~clucas/downloads/clucas-public-key.txt
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: 192.168.0.24
X-SA-Exim-Mail-From: clucas@rotomalug.org
Subject: Re: UserMode bug in 2.6.11-rc5?
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on vodka.iomeda.fr)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristian Sørensen (ks@cs.aau.dk) wrote:
> Hi!
> 
> I've just tried usermode Linux with a 2.6.11-rc5 kernel. My kernel boots, but 
> when the shell is to be spawned it freezes:
> ----
> INIT: Entering runlevel: 2
> Starting system log daemon: syslogd.
> Starting kernel log daemon: klogd.
> Starting internet superserver: inetd.
> Starting deferred execution scheduler: atd.
> Starting periodic command scheduler: cron.
> INIT: Id "0" respawning too fast: disabled for 5 minutes
> INIT: Id "1" respawning too fast: disabled for 5 minutes
> INIT: Id "2" respawning too fast: disabled for 5 minutes
> INIT: Id "c" respawning too fast: disabled for 5 minutes
> INIT: no more processes left in this runlevel
> ----
> 
> I've attached the .config for both 2.6.10 (working perfectly) and the one for 
> 2.6.11-rc5. The root filesystem this: 
> http://prdownloads.sourceforge.net/user-mode-linux/Debian-3.0r0.ext2.bz2

Hi,

What do you have in your /etc/inittab of your root_fs ?
I think you sould replace tty0 by vc/0 such as.

I have had this on a kernel 2.6.10 and debian-3.1 root_fs.

	~Christophe

