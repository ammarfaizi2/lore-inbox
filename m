Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264943AbTAWHvM>; Thu, 23 Jan 2003 02:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264950AbTAWHvM>; Thu, 23 Jan 2003 02:51:12 -0500
Received: from adsl-67-64-81-217.dsl.austtx.swbell.net ([67.64.81.217]:42669
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S264943AbTAWHvK>; Thu, 23 Jan 2003 02:51:10 -0500
Subject: Kernel build problem, Need help.
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1043308727.8275.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 23 Jan 2003 01:58:48 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I patched 2.4.20 with O(1) sched + P4 O(1) sched patches and the kernel
will not build fully. I added a line to list.h "typedef struct list_head
list_t;" and that made it at least compile for a few mins till ld is
called for kernel.o, then poof.

Error output is here:

http://digitalroadkill.net/public/kernel/2.4.20-rmap15b-xfs-o1-lvm106-error3.txt

I'm trying to get this set of patches into my beta environment asap, but
I'm not sure why I've run into this. If anyone can help I'd appreciate
it.

TIA.

--
GrandMasterLee

