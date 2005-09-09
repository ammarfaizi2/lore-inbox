Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030303AbVIITYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030303AbVIITYQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 15:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbVIITYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 15:24:15 -0400
Received: from S0106000ea6c7835e.no.shawcable.net ([70.67.106.153]:30426 "EHLO
	prophet.net-ronin.org") by vger.kernel.org with ESMTP
	id S1030303AbVIITYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 15:24:13 -0400
Date: Fri, 9 Sep 2005 12:21:13 -0700
From: carbonated beverage <ramune@net-ronin.org>
To: linux-kernel@vger.kernel.org
Subject: errs from build/makefiles
Message-ID: <20050909192113.GA8621@prophet.net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm assuming some bash-isms crept into the tree, as I got these:

  LD      net/built-in.o
/bin/sh: +@: not found
make[1]: warning: jobserver unavailable: using -j1.  Add `+' to parent make rule.
  CHK     include/linux/compile.h
dnsdomainname: Unknown host
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      vmlinux
  SYSMAP  System.map

(Note, I was building with -j3)

As the system I was using is a bit... er.... slow, I'd prefer not to kick
off another build with V=1 :-)
Not to mention, egrep -r is kinda painful over NFS on a slow link.

Pulled via git (after fixing git scripts to use bash instead of /bin/sh):

$ cat .git/HEAD 
5f5024130287a9467a41b9f94ec170958ae45cbd

-- DN
Daniel
