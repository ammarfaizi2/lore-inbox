Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbTLVNnF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 08:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264536AbTLVNnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 08:43:04 -0500
Received: from grex.cyberspace.org ([216.93.104.34]:3089 "HELO
	grex.cyberspace.org") by vger.kernel.org with SMTP id S264531AbTLVNnD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 08:43:03 -0500
Date: Mon, 22 Dec 2003 08:43:35 -0500
From: Hal Nine <hal9@cyberspace.org>
Message-Id: <200312221343.IAA22752@grex.cyberspace.org>
To: linux-kernel@vger.kernel.org
Subject: HD errors on Linux 2.4.23, but not on W2K
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a MAXSTOR 6L040J2 40 Gb drive that under kernel 2.4.23
is giving me { DriveReady SeekComplete Error } { UncorrectableError }
every two sectors when I try to access it (a simple hdparm -t /dev/hda)
will do.  I tried disable DMA, etc., etc., even chaning to 2.6.0, but
still those errors persists.

Usually this is a sign of old age, bad HD, etc but the strangest
thing is that this is a W2K machine (I'm booting via NFS root here)
and it works like a charm.  Not a single burp, even when copying
files around. 

A surface scan by CHKDSK doesn't find anything.

Any ideas?

Thanks,
H9
.
