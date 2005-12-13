Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932576AbVLMS4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932576AbVLMS4w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 13:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932608AbVLMS4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 13:56:51 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:32728 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S932576AbVLMS4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 13:56:51 -0500
Date: Tue, 13 Dec 2005 19:56:50 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Cc: Linux-VServer ML <vserver@list.linux-vserver.org>
Subject: [ANNOUNCE] second stable release of Linux-VServer 
Message-ID: <20051213185650.GA6466@MAIL.13thfloor.at>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
	Linux-VServer ML <vserver@list.linux-vserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well, as the OpenVZ folks announced their release on LKML
I just decided to do similar for the Linux-VServer release,
so please let me know if that is not considered appropriate.

Short Overview:

Linux-VServer, a soft partitioning concept based on Contexts
(Process, Network and Filesystem Isolation) which permits
the creation of many independent Virtual Private Servers (VPS)
that run simultaneously on a single physical server at full
speed, efficiently sharing hardware resources.

A VPS provides an almost identical operating environment as
a conventional Linux Server. All services, such as ssh, mail,
Web and databases, can be started on such a VPS, without
(or in special cases with only minimal) modification, just
like on any real server.

The Project is following the kernel development very closely,
and provides Stable as well as Development patches for 2.6
and 2.4 vanilla kernels.

(more details can be found at http://linux-vserver.org/)

The patch is available here:
http://www.13thfloor.at/vserver/s_rel26/v2.01/

For the lkml folks, the broken out version of the patch
is probably most interesting (if there is some detailed
interest, I'll comment on the patches ...)

http://www.13thfloor.at/vserver/s_rel26/v2.01/split-2.6.14.3-vs2.01.tar.bz2
(IMHO too huge to attach them inline)

best,
Herbert

