Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261711AbSJDWtf>; Fri, 4 Oct 2002 18:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261742AbSJDWtf>; Fri, 4 Oct 2002 18:49:35 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:33611 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S261711AbSJDWte>; Fri, 4 Oct 2002 18:49:34 -0400
Date: Fri, 4 Oct 2002 16:03:32 -0700
From: "Matt D. Robinson" <yakker@aparity.com>
Message-Id: <200210042303.g94N3Wo10004@nakedeye.aparity.com>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] LKCD for 2.5.40
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all:

These are the patches (9 in all) for the Linux Kernel Crash Dump
modifications for 2.5.  This allows crash dumps to be built as a
module in the kernel and also includes a breakdown of a few of the
changes needed in the kernel.  The current version will allow for
block dumping, and has the ability to readily integrate network
dumping (a la Red Hat).

The big debatable issue I can see right away is the dump_in_progress
addition to schedule(), which can certainly be moved out or modified
to appease people wanting a tight scheduler loop.

Please accept these patches or provide feedback on how we can
modify them for acceptance.  Thanks,

--Matt
