Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315419AbSHDJ7l>; Sun, 4 Aug 2002 05:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318140AbSHDJ7l>; Sun, 4 Aug 2002 05:59:41 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:7442 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S315419AbSHDJ7k>; Sun, 4 Aug 2002 05:59:40 -0400
Date: Sun, 4 Aug 2002 12:02:58 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 make allyesconfig - errors and warnings
Message-ID: <20020804100258.GB28559@louise.pinerecords.com>
References: <28360.1028454667@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28360.1028454667@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.19-pre10/sparc SMP
X-Uptime: 60 days, 21:35
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.4.19 make allyesconfig got two errors and lots of warnings.
> 
> CONFIG_JFFS2_FS - duplicate symbols between jffs2 and ppp_deflate - an
> oldy but goody.
> 
> CONFIG_IEEE1394 - does not build
> drivers/ieee1394/nodemgr.c: In function `nodemgr_host_reset':
> drivers/ieee1394/nodemgr.c:1307: parse error before `else'
> 
> The rest are "just" warnings.

Just an idea - wouldn't it be useful to have dedicated errata pages
for recent stable kernels where important patches (such as the 2.4.18
personality fix, 2.4.18 samba oops fix or the upcoming 2.4.19 ide
updates) would be published? Finding a link to these in the kernel FAQ,
people would just patch their kernels instead of posting to lkml, which
could cut on the amount of duplicate bugreports significantly plus folks
wouldn't have to wait 6 months+ for an official update to get rid of an
oops.

T.
