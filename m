Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbUCARm7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 12:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbUCARm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 12:42:59 -0500
Received: from waste.org ([209.173.204.2]:39317 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261380AbUCARm5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 12:42:57 -0500
Date: Mon, 1 Mar 2004 11:42:56 -0600
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.3-tiny1 for small systems
Message-ID: <20040301174255.GV3883@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the latest release of the -tiny kernel tree. The aim of this
tree is to collect patches that reduce kernel disk and memory
footprint as well as tools for working on small systems. Target users
are things like embedded systems, small or legacy desktop folks, and
handhelds.

Latest release includes:
 - update to 2.6.3
 - add latest netdev patchkit (Jeff Garzik)
 - optional minimal VT support
 - optional sysfs backing store support (Maneesh Soni)
 - optional legacy pty support (H Peter Anvin)
 - optional support for ELF with a.out libs (Peter Mazinger)
 - optional configurable alignment flags (Denis Vlasenko)
 - various other minor cleanups

The big new feature is a stripped down version of the virtual terminal
subsystem, especially useful for systems that run GUIs. This feature
is still a work in progress.

The patch can be found at:

 http://selenic.com/tiny/2.6.3-tiny1.patch.bz2
 http://selenic.com/tiny/2.6.3-tiny1-broken-out.tar.bz2

Webpage for your bookmarking pleasure:

 http://selenic.com/tiny-about/

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
