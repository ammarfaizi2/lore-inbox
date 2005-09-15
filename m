Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbVIOLms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbVIOLms (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 07:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbVIOLms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 07:42:48 -0400
Received: from mail.portrix.net ([212.202.157.208]:4507 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S1751096AbVIOLmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 07:42:47 -0400
Message-ID: <43295E30.7030508@ppp0.net>
Date: Thu, 15 Sep 2005 13:42:40 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050817)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.14-rc1 load average calculation broken?
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get a steady 2.00 there. I stopped unnecessary processes etc.
load average seems to be invariant

top - 13:41:32 up  4:44,  2 users,  load average: 2.00, 2.00, 2.00
Tasks: 108 total,   2 running, 105 sleeping,   0 stopped,   1 zombie
Cpu(s):  0.0% us,  0.0% sy,  0.0% ni, 99.7% id,  0.3% wa,  0.0% hi,  0.0% si
Mem:    515112k total,   319980k used,   195132k free,    58036k buffers
Swap:  1991976k total,      600k used,  1991376k free,   183836k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND

15234 root      16   0  2196 1116  844 R  0.7  0.2   0:00.02 top

 8368 jdittmer  15   0  4104 2200 1512 S  0.3  0.4   0:00.05 ssh

    1 root      16   0  1796  628  532 S  0.0  0.1   0:01.11 init

...

-- 
Jan
