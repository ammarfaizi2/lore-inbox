Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264318AbUEIJNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264318AbUEIJNx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 05:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264321AbUEIJNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 05:13:53 -0400
Received: from port-212-202-41-96.reverse.qsc.de ([212.202.41.96]:28289 "EHLO
	rocklinux-consulting.de") by vger.kernel.org with ESMTP
	id S264318AbUEIJNv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 05:13:51 -0400
Date: Sun, 09 May 2004 11:13:50 +0200 (CEST)
Message-Id: <20040509.111350.67880957.rene@rocklinux-consulting.de>
To: kangur@polcom.net
Cc: linux-kernel@vger.kernel.org, rock-user@rocklinux.org
Subject: Re: Distributions vs kernel development
From: Rene Rebe <rene@rocklinux-consulting.de>
In-Reply-To: <Pine.LNX.4.58.0405091057060.14709@alpha.polcom.net>
References: <200405090707.i49776Iv000342@81-2-122-30.bradfords.org.uk>
	<20040509.105253.26927810.rene@rocklinux-consulting.de>
	<Pine.LNX.4.58.0405091057060.14709@alpha.polcom.net>
X-Mailer: Mew version 3.1 on XEmacs 21.4.13 (Rational FORTRAN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Spam-Score: 0.0 (/)
X-Spam-Report: Spam detection software, running on the system "heap.localnet", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or block
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, On: Sun, 9 May 2004 10:59:48 +0200 (CEST), Grzegorz
	Kulewski <kangur@polcom.net> wrote: > You have binary packages in
	Gentoo so you can build once for many > machines. All you need is to
	add one option to /etc/make.conf. [...] 
	Content analysis details:   (0.0 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On: Sun, 9 May 2004 10:59:48 +0200 (CEST),
    Grzegorz Kulewski <kangur@polcom.net> wrote:

> You have binary packages in Gentoo so you can build once for many 
> machines. All you need is to add one option to /etc/make.conf.

But the last time I took a look not even an installer or such. +
Gentoo has no support for custom modifications not even thinking about
a way to group such custom modifications / build configuration into a
well defined way to form a distribution. + ROCK Linux has a real
sandbox build environment, not this optimization via CFLAGS, and so on
Gentoo wannabe.

ROCK Linux is a build kit, allowing to define a set configurations /
modifications to create e.g. special embedded or server distributions
without the need to repackage all the packages and writing a build
script for those ... And when you read some ebuild scripts you find
the ROCK Linux automatics and tag based ASCI package description
format very pleasant, e.g.:

  http://svn2.rocklinux-consulting.de/rock-linux/trunk/package/base/rsync/

Sincerely yours,
  René Rebe
    - ROCK Linux stable release maintainer

--  
René Rebe - Europe/Germany/Berlin
  rene@rocklinux.org rene@rocklinux-consulting.de
http://www.rocklinux.org http://www.rocklinux-consulting.de

