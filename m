Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262662AbVCMDgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262662AbVCMDgE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 22:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbVCMDgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 22:36:04 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:39412 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S262662AbVCMDgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 22:36:02 -0500
Date: Sat, 12 Mar 2005 22:36:00 -0500
From: Mark Studebaker <mds@mds.gotdns.com>
Subject: ancient portmap segfault
To: lkml <linux-kernel@vger.kernel.org>
Message-id: <4233B520.7010307@mds.gotdns.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030420
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I upgraded from 2.6.5 to 2.6.11.2 and my ancient (libc4 a.out) /sbin/portmap from 1994 that's been running without complaint
on kernels for 11 years now consistently segfaults.

I upgraded to a version 4 RPM (circa 2002) and that fixed it.

If some compatibility was broken on purpose, that's fine, although I couldn't find anything in the kernel docs.
I know, I should upgrade everything, but that can break a lot of things too...
Thought I'd mention it though in case it's a bug or somebody else has the same problem.

mds


