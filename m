Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbTDSKR4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 06:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263377AbTDSKR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 06:17:56 -0400
Received: from lucidpixels.com ([66.45.37.187]:26257 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S263375AbTDSKR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 06:17:56 -0400
Message-ID: <3EA12521.3010005@lucidpixels.com>
Date: Sat, 19 Apr 2003 06:29:53 -0400
From: Justin Piszcz <jpiszcz@lucidpixels.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: New kernel error/warning? (2.4.21-pre7)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apr 19 03:20:21 kernel: hda: task_no_data_intr: error=0x04 { 
DriveStatusError }

I do not remember getting this with <= 2.4.21-pre6.

A quick search on google reveals

csociety-ftp.ecn.purdue.edu/pub/kernel/v2.4/testing/cset/cset-1.930.4.1.txt
... task_no_data_intr: status=0x51 { DriveReady SeekComplete Error } # > 
hda: task_no_data_intr:
error=0x04 ... patch is against both 2.4.20 and 2.4.21-pre, is just ...
51k - Cached - Similar pages

Could anyone explain if this error/warning is ok, as I have never seen 
it before, I've tried turning all the options off as well, -c0 -d0 -u1 
-W0, still shows up.

I'm assuming it is a warning I can ignore?

