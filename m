Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbVB0BIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVB0BIL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 20:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVB0BIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 20:08:11 -0500
Received: from hera.cwi.nl ([192.16.191.8]:24815 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261339AbVB0BII (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 20:08:08 -0500
Date: Sun, 27 Feb 2005 02:07:57 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] partitions/msdos.c
Message-ID: <20050227010757.GC14236@apps.cwi.nl>
References: <20050226213459.GA21137@apps.cwi.nl> <16928.62091.346922.744462@hertz.ikp.physik.tu-darmstadt.de> <Pine.LNX.4.58.0502261424430.25732@ppc970.osdl.org> <20050226225203.GA25217@apps.cwi.nl> <Pine.LNX.4.58.0502261510030.25732@ppc970.osdl.org> <20050226234053.GA14236@apps.cwi.nl> <Pine.LNX.4.58.0502261546380.25732@ppc970.osdl.org> <16929.6319.149849.305237@hertz.ikp.physik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16929.6319.149849.305237@hertz.ikp.physik.tu-darmstadt.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2005 at 01:47:43AM +0100, Uwe Bonnes wrote:

> on a Suse 9.2 System with Suse Hotplug, the phantom partition was somehow
> recognized as Reiserfs, and then the Hotplug mechanism trying to mount the 
> bogus partition as a Reiser Filesystem ended in an Oops...

Always report the oops. It is well-known that mounting garbage may crash
the kernel. Earlier the reply was "don't do that then". Nowadays we have
more layers of software trying to probe and do automatic things, and the
kernel must survive attempts to mount garbage.

Andries
