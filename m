Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbVCVS2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVCVS2g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 13:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVCVS0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 13:26:46 -0500
Received: from alog0692.analogic.com ([208.224.223.229]:31209 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261628AbVCVS01
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 13:26:27 -0500
Date: Tue, 22 Mar 2005 13:23:55 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: lseek on /proc/kmsg
Message-ID: <Pine.LNX.4.61.0503221320090.5551@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anybody know what is __supposed__ to happen with lseek()
on /proc/kmsg.  Right now, it does nothing, always returns
0. Given that, how am I supposed to clear the kmsg buffer
since it's not a terminal??

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
