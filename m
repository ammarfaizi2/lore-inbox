Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262400AbVCBSXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbVCBSXv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 13:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbVCBSXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 13:23:35 -0500
Received: from rev.193.226.232.215.euroweb.hu ([193.226.232.215]:53934 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262400AbVCBSRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 13:17:31 -0500
To: akpm@osdl.org
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [request for inclusion] Filesystem in Userspace 
Message-Id: <E1D6YPJ-0000Jv-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 02 Mar 2005 19:17:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew!

Do you have any objections to merging FUSE in mainline kernel?

It's been in -mm for the 2.6.11 cycle, and the same code was released
a month ago as FUSE-2.2.  So it should have received a fair amount of
testing, with no problems found so far.

The one originally merged into -mm already addressed all major issues
that people found (most importantly the OOM deadlock thing), and
though there were some minor changes in the interface since then, I
feel that the current kernel interface will stand up to the test of
time.

Thanks,
Miklos
