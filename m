Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266157AbUHMQOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266157AbUHMQOY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 12:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266201AbUHMQOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 12:14:24 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:48649 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S266157AbUHMQOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 12:14:21 -0400
Message-ID: <411CE8DC.9010609@superbug.demon.co.uk>
Date: Fri, 13 Aug 2004 17:14:20 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040812)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Latency profiling.
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been looking, but I cannot find out if anyone has already done 
what I want.

I have a problem that my desktop linux system becomes un-responsive when 
there is a lot of Hard Disc access. I.E. During HD access, the mouse 
fails to move.

I suspect that this is due to a certain kernel process holding onto the 
CPU resources too long without letting the kernel schedule a different 
process.

I therefore need a kernel profiler that will log every kernel 
schedule/context switch, and if the interval between any switch is 
greater than X, it will write a log entry, telling me which 
process/function/module was holding onto the CPU for too long.

I could then use this tool to help me track down exactly where the 
problem is, and therefore hopefully find a fix for it.

Does a tool like this already exist?

James
