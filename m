Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267625AbUHZFIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267625AbUHZFIi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 01:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267632AbUHZFIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 01:08:38 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:12168 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S267625AbUHZFIh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 01:08:37 -0400
Message-ID: <412D6FF9.7070001@rtr.ca>
Date: Thu, 26 Aug 2004 01:07:05 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-rc1
References: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On the one system I have tried this kernel on, it hangs solid
just after successful DHCP negotiation (userland) on Debian-Sarge.
System is using SMP kernel on SMP board with a single P3-750 CPU.

Reconfiguring the kernel to exclude the net-filter stuff fixes it for me.

The 2.6.8-rc4 kernel was the previous version on the same machine,
and did not have this problem.

I'm kinda under deadline right now for something else,
so I haven't taken time to chase it any further.

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
