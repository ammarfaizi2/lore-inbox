Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263145AbTC1VPb>; Fri, 28 Mar 2003 16:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263147AbTC1VPb>; Fri, 28 Mar 2003 16:15:31 -0500
Received: from [66.227.5.25] ([66.227.5.25]:49812 "EHLO ns1.sevaa.com")
	by vger.kernel.org with ESMTP id <S263145AbTC1VPa>;
	Fri, 28 Mar 2003 16:15:30 -0500
Subject: 2.5.66-gcov
From: Paul Larson <plars@linuxtestproject.org>
To: lse-tech@lists.sourceforge.net, ltp-coverage@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 28 Mar 2003 16:32:27 -0600
Message-Id: <1048890755.3367.65.camel@plap>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a new version of the gcov-kernel patch on lse at: 
http://sourceforge.net/project/showfiles.php?group_id=8875&release_id=74815

Changes in this release are: 
-resync with 2.5.66 
-detect gcc version for a section that needs to know that 
-profiling of modules is fixed 

The purpose of this patch is to allow utilization of the gcov tool
against a running kernel.  This is different from most other profiling
methods because it can easily tell you things like: which lines of code
are executed, how many times they are executed, and how often different
branches are taken. 

For anyone interested in this type of research, there is also a new
mailing list at: 
http://lists.sourceforge.net/lists/listinfo/ltp-coverage

Thanks, 
Paul Larson

