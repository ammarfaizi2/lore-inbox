Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262717AbUKRAkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262717AbUKRAkj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 19:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbUKQXy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 18:54:57 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:54179 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S262669AbUKQXnz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 18:43:55 -0500
To: linux-kernel@vger.kernel.org
cc: Ian.Pratt@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Steven.Hand@cl.cam.ac.uk
Subject: Xen 2.0 VMM patches
Date: Wed, 17 Nov 2004 23:43:53 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1CUZSs-000502-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The Xen team would like to start submitting upstream the patches
required to enable Linux to run over the Xen 2.0 Virtual Machine
Monitor. For more information about Xen see: http://xen.sf.net

There are three main classes of patch required:
  core        : small patches that provide extra hooks for arch-xen
  arch-xen    : large patch to add arch/xen and include/asm-xen 
  xen-drivers : patch to add virtual block, network and console drivers

We're proposing to submit the 'core' patches first, as these
probably require closest inspection (the others are all new
files in new directories, so can't break existing architectures).

There is already a significant user base and lively developer
community backing the Xen project, so we're confident we will
have the resources to maintain arch-xen on Linux 2.6 going
forward (as well as Linux 2.4/NetBSD/FreeBSD/etc).

Let us know what you think of the patches ;-)

Cheers,
Ian, Keir, Christian, Steve


Original Xen 2.0 release annoucement:

The Xen team are pleased to announce the release of Xen 2.0, the
open-source Virtual Machine Monitor.  Xen enables you to run
multiple operating systems images concurrently on the same
hardware, securely partitioning the resources of the machine
between them. Xen uses a technique called 'para-virtualization'
to achieve very low performance overhead -- typically just a few
percent relative to native.  This new release provides kernel
support for Linux 2.4.27/2.6.9, NetBSD and FreeBSD.

Xen 2.0 runs on almost the entire set of modern x86 hardware
supported by Linux, and is easy to 'drop-in' to an existing Linux
installation.  The new release has a lot more flexibility in how
guest OS virtual I/O devices are configured. For example, you can
configure arbitrary firewalling, bridging and routing of guest
virtual network interfaces, and use copy-on-write LVM volumes or
loopback files for storing guest OS disk images.  Another new
feature is 'live migration', which allows running OS images to be
moved between nodes in a cluster without having to stop
them. Visit http://xen.sf.net for downloads and documentation.



