Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272417AbTG3Atb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 20:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272428AbTG3Atb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 20:49:31 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:34446 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S272417AbTG3Ata (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 20:49:30 -0400
Message-ID: <3F26FA14.20700@cornell.edu>
Date: Tue, 29 Jul 2003 18:49:56 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030721 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Binfmt_misc on 2.4 and 2.5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The errors below have been there for as long as I can remember, even
under 2.4. The binfmt_misc folder in proc is empty on boot, even though
I have the binfmt_misc module in the kernel (I think it didn't work
builtin as well, but I haven't tested recently).

Jul 29 18:26:13 cobra wine: /etc/rc5.d/S98wine: line 16:
/proc/sys/fs/binfmt_misc/register: No such file or directory

Jul 29 18:26:13 cobra wine: /etc/rc5.d/S98wine: line 17:
/proc/sys/fs/binfmt_misc/register: No such file or directory

So what's wrong? Is this a kernel issue.. I thought it probably is.
Or have I made a mistake somewhere...

