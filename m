Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265314AbTLHDIq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 22:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265315AbTLHDIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 22:08:46 -0500
Received: from sweetums.bluetronic.net ([24.199.150.42]:37360 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S265314AbTLHDIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 22:08:44 -0500
Date: Sun, 7 Dec 2003 22:06:05 -0500 (EST)
From: Ricky Beam <jfbeam@bluetronic.net>
To: David Dillow <dave@thedillows.org>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>,
       <kbuild-devel@lists.sourceforge.net>
Subject: Re: [BK PATCH 0/3] Teach kbuild to pull files from BK repository
In-Reply-To: <1070595121.4574.24.camel@ori.thedillows.org>
Message-ID: <Pine.GSO.4.33.0312072204020.13188-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Dec 2003, David Dillow wrote:
>I finally got tired of having to run "bk -r get" before doing a build, so I
...

This is not necessary...

  spacemeat:/usr/src/linux-2.6-bk# cat BitKeeper/etc/config
  # Don't change this unless you're Linus
  logging_ask:no
  description: Linux kernel tree
  logging: logging@openlogging.org
  email: torvalds@transmeta.com

  # cramer / why isn't this the default?
  []checkout:get

That last line is the magic.  It's documented in the BK FAQ (more than once
I think.)

--Ricky


