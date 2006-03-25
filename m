Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbWCYOVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWCYOVi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 09:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWCYOVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 09:21:38 -0500
Received: from ns.suse.de ([195.135.220.2]:42706 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750991AbWCYOVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 09:21:38 -0500
From: Andi Kleen <ak@suse.de>
To: sam@ravnborg.org
Subject: ccache complains in latest git about -p
Date: Sat, 25 Mar 2006 15:21:32 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603251521.32217.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ccache complains for me on x86-64 now:

> make CC=ccache 
make -C /home/lsrc/quilt/linux O=/home/lsrc/quilt/obj
ccache: invalid option -- p
  Using /home/lsrc/quilt/linux as source for kernel

It's probably harmless but looks ugly

> make CC=ccache  V=1
make -C /home/lsrc/quilt/linux O=/home/lsrc/quilt/obj
make -C /home/lsrc/quilt/obj \
KBUILD_SRC=/home/lsrc/quilt/linux \
KBUILD_EXTMOD="" -f /home/lsrc/quilt/linux/Makefile _all
ccache: invalid option -- p

-Andi
