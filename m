Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264973AbUF1OnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264973AbUF1OnG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 10:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264979AbUF1OnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 10:43:06 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:48343 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264973AbUF1OnD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 10:43:03 -0400
Date: Mon, 28 Jun 2004 16:42:53 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org
Subject: make foo/bar.o fails in untouched kernel trees
Message-ID: <20040628144253.GB5106@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam, this should be something for you.

tar xvjf linux-2.6.7.tar.bz2
cd linux-2.6.7
cp /boot/config-2.6.6 .config
make oldconfig
make drivers/ide/ide.o

The above didn't work for me, as the symlink from asm-ARCH to asm was
still missing.  Is there a simple fix for this?

Jörn

-- 
When in doubt, punt.  When somebody actually complains, go back and fix it...
The 90% solution is a good thing.
-- Rob Landley
