Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269017AbUJKOnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269017AbUJKOnS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 10:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269012AbUJKOlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 10:41:01 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:33258 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S269039AbUJKOgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 10:36:51 -0400
Subject: Re: 2.6.9-rc4-mm1
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org
Content-Type: text/plain
Organization: 
Message-Id: <1097505053.2674.7163.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 11 Oct 2004 10:30:53 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please get these 4 patches into the 2.6.9 release:

distinct-tgid-tid-cpu-usage.patch
  distinct tgid/tid CPU usage

show-aggregate-per-process-counters-in-proc-pid-stat-2.patch
  show aggregate per-process counters in /proc/PID/stat 2

kallsyms-data-size-reduction--lookup-speedup.patch
  kallsyms data size reduction / lookup speedup

fix-process-start-times.patch
  Fix reporting of process start times

BTW, the explanation for ps-shows-wrong-ppid.patch
is messed up. It referrs to a "Thread 3", but there
is no such thread. An explanation in terms of clone()
would also be an improvement.




