Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262713AbTDNCkI (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 22:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbTDNCkI (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 22:40:08 -0400
Received: from franka.aracnet.com ([216.99.193.44]:1213 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262713AbTDNCkI (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 22:40:08 -0400
Message-ID: <3E9A2258.9020507@BitWagon.com>
Date: Sun, 13 Apr 2003 19:52:08 -0700
From: John Reiser <jreiser@BitWagon.com>
Organization: -
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: observe & control thread state for exit futex ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How can a debugger, newly attached to an arbitrary thread, determine whether
the thread has a pending exit futex and associated memory location to clear
[CLONE_CHILD_CLEARTID flag and child_tid_ptr parameter at __clone()]?

If so, then how can the debugger determine the address, change the address,
cancel the futex, and/or intercept the notification?

