Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbTGPGTX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 02:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263894AbTGPGTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 02:19:23 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:56572 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S262601AbTGPGTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 02:19:12 -0400
Subject: Re: modules problems with 2.6.0 (module-init-tools-0.9.12)
From: Martin Schlemmer <azarah@gentoo.org>
To: Diego Calleja =?ISO-8859-1?Q?Garc=EDa?= <diegocg@teleline.es>
Cc: Piet Delaney <piet@www.piet.net>, rddunlap@osdl.org,
       fsanchez@mail.usfq.edu.ec, KML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030716021210.56ea8360.diegocg@teleline.es>
References: <3F147B8F.5000103@mail.usfq.edu.ec>
	 <20030715152257.614d628b.rddunlap@osdl.org>
	 <1058313192.21300.988.camel@www.piet.net>
	 <20030716021210.56ea8360.diegocg@teleline.es>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1058337248.13515.1381.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 16 Jul 2003 08:34:09 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-07-16 at 02:12, Diego Calleja García wrote:
> El 15 Jul 2003 16:53:12 -0700 Piet Delaney <piet@www.piet.net> escribió:
> 
> > On Tue, 2003-07-15 at 15:22, Randy.Dunlap wrote:
> > 
> > I heard that if you install the new module-init-tools package in
> > /sbin that you would be able to boot old kernels. Is that true?
> 
> It works here.
> i've a debian distro, i apt-get'ed module-init-tools. Man modprobe says:
> 
> BACKWARDS COMPATIBILITY
>        This version of insmod is  for  kernels  2.5.48  and  above.   If  it
>        detects  a kernel with support for old-style modules (for which much of
>        the work was done in userspace), it will attempt to run  insmod.modu-
>        tils in its place, so it is completely transparent to the user.
> 
> diego@estel:~$ ls -l /sbin/insmod*
> -rwxr-xr-x    1 root     root         5072 2003-06-15 12:27 /sbin/insmod
> -rwxr-xr-x    1 root     root          359 2003-03-06 15:50 /sbin/insmod_ksymoops_clean
> -rwxr-xr-x    1 root     root        95372 2003-03-06 15:50 /sbin/insmod.modutils
> 
> 
> Looking at the size, insmod.modutils seems the 2.4 insmod loader. 

That is Debian doing things differently again.  The vanilla
modules-init-tools will run insmod.old:

  $ ls /sbin/insmod*
  /sbin/insmod  /sbin/insmod.old  /sbin/insmod.static 
/sbin/insmod_ksymoops_clean
  $ 

Anyhow, usually reading the documentation (*hint* README *hint*)
should help.


-- 
Martin Schlemmer


