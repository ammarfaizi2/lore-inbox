Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbWG3KvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWG3KvX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 06:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbWG3KvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 06:51:23 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:15522
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S932258AbWG3KvW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 06:51:22 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Trying to get my shiny new G5 (quad 2.5GHz) to boot under Linux
Date: Sun, 30 Jul 2006 12:50:44 +0200
User-Agent: KMail/1.9.1
References: <200607301023.k6UANWKj019190@harpo.it.uu.se>
In-Reply-To: <200607301023.k6UANWKj019190@harpo.it.uu.se>
Cc: benh@kernel.crashing.org, paulus@samba.org, linux-kernel@vger.kernel.org,
       mrmacman_g4@mac.com
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200607301250.44914.mb@bu3sch.de>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 July 2006 12:23, Mikael Pettersson wrote:
> On Sat, 29 Jul 2006 22:06:56 -0400, Kyle Moffett wrote:
> >I just bought a brand new absolute-bleeding-edge Quad 2.5GHz G5 (it's  
> >actually dual-proc dual-core, but that's marketing for you) and I'm  
> >trying to find a kernel that will boot the system.  Well actually I'm  
> >_trying_ to install Debian but I have yet to even get to mounting the  
> >initramfs.  Here's a list of the kernels I've tried:
> >
> >   Debian-Installer beta2 (I think this is 2.6.15?)
> >   Debian 2.6.16-1-powerpc64
> >   Debian 2.6.17-1-powerpc64
> >   Custom 2.6.18-rc2+git (64821324ca49f24be1a66f2f432108f96a24e596)
> ...
> >If you have gotten Linux to boot on the Quad G5; I'd really  
> >appreciate it if you could send me a working .config (or even better,  
> >a working vmlinux image).  Thanks for all your help!
> 
> You really should try YDL 4.1's kernel. I would be very
> surprised if it didn't work.

It boots, but it's crap. It has not the required Windtunnel
support built in (kernel too old), so the fans go crazy.
(And a G5 with fans going crazy is _really_ annoying).

But installing YDL 4.1 is good to bootstrap another distribution
plus kernel from it.
I first installed YDL 4.1 and (somehow, don't remember all the
dirty details) bootstrapped a Ubuntu on it. After that I deleted
the YDL partition again and made it my /home partition.

-- 
Greetings Michael.
