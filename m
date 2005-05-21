Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbVEUFtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbVEUFtO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 01:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbVEUFtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 01:49:14 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:30351 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S261663AbVEUFtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 01:49:10 -0400
Date: Fri, 20 May 2005 22:48:18 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: timur.tabi@ammasso.com, lkml@chrisli.org, linux-kernel@vger.kernel.org
Subject: Re: Kbuild trick
Message-Id: <20050520224818.1e5dc796.rdunlap@xenotime.net>
In-Reply-To: <20050521051217.GA8191@mars.ravnborg.org>
References: <20050517201148.GA12997@64m.dyndns.org>
	<428B4C67.5090307@ammasso.com>
	<20050518123854.GA13452@64m.dyndns.org>
	<428B646C.3030501@ammasso.com>
	<20050518132417.GA14488@64m.dyndns.org>
	<428B7143.4090607@ammasso.com>
	<20050518182250.GB8130@mars.ravnborg.org>
	<428B8809.8060406@ammasso.com>
	<20050520193706.GA8225@mars.ravnborg.org>
	<20050520234353.GM22946@ca-server1.us.oracle.com>
	<20050521051217.GA8191@mars.ravnborg.org>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 May 2005 07:12:17 +0200 Sam Ravnborg wrote:

| On Fri, May 20, 2005 at 04:43:53PM -0700, Joel Becker wrote:
| > On Fri, May 20, 2005 at 09:37:06PM +0200, Sam Ravnborg wrote:
| > > For both kernel 2.4 and 2.6 you can split up your makefile like this:
| > > makefile <= all the external modules specific part
| > > Makefile <= the kbuild specific part
| > 
| > 	You could also use our fake-2.6-kbuild-for-2.4 makefile,
| > retrievable via:
| > 
| > svn cat -r 2205 http://oss.oracle.com/projects/ocfs2/src/trunk/Kbuild-24.make
| 
| $ which svn
| which: no svn in (/bin:/usr/bin:/.....)
| 
| Care to post a copy?

svn == Subversion, at http://subversion.tigris.org/

oh, you mean post a copy of Kbuild-24.make; yes, that makes sense.

---
~Randy
