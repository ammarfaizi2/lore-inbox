Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316258AbSHOBUt>; Wed, 14 Aug 2002 21:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316430AbSHOBUs>; Wed, 14 Aug 2002 21:20:48 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:37074 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316258AbSHOBUs>; Wed, 14 Aug 2002 21:20:48 -0400
Message-Id: <200208150124.g7F1Ob401335@eng4.beaverton.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: anybody porting 2.4.19 i/o stat patches to 2.5?
Date: Wed, 14 Aug 2002 18:24:36 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These patches allowed you to collect I/O information on a per-partition
basis, as well as removing the restriction about only monitoring the
first sixteen disks.  Is anybody working on porting this to 2.5?  If not,
I'll do it.

These 2.4.19 patches did not, it appear, provide any means (through
/proc, for example, as in the original patches) of retrieving the
information even though code was added to collect it.  Any reason why not?

Rick
