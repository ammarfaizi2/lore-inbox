Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266608AbUF3J4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266608AbUF3J4H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 05:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266613AbUF3J4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 05:56:06 -0400
Received: from msdo0001.xtend.de ([217.27.0.68]:26773 "EHLO
	msdo0001.triaton-webhosting.com") by vger.kernel.org with ESMTP
	id S266608AbUF3Jz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 05:55:57 -0400
Message-ID: <40E28E22.8010606@triaton-webhosting.com>
Date: Wed, 30 Jun 2004 11:55:46 +0200
From: Georg Chini <georg.chini@triaton-webhosting.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: pdflush uses all cpu-time with 2.6.7 and slow media
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

there seems to be a problem with pdflush and
slow media in 2.6.7. I'm using the packet-writing patch
maintained by Peter Osterlund to write to dvd+rw.
When I copy large files to the dvd, pdflush
starts using all cpu-time up to a point where
the system hangs completely. I found a posting here
with a similar problem concerning nfs and pdflush
(28.04.2004, Brent Cook). This thread mentions,
that the problem is not observable in 2.6.5.
So I tried 2.6.5 and everything works fine if
I set dirty_ratio in /proc/sys/vm to 15. With
the default value of 40 there are still some problems,
but it is way better than 2.6.7-bk12. BTW my machine
is a dual PIII.
Any idea what might cause the problem? Any more
information I should give?
As I'm not on the list, please CC to me in your replies.

Thanks in advance
                  Georg Chini

