Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262559AbUCJI4l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 03:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262561AbUCJI4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 03:56:41 -0500
Received: from smtp-out7.blueyonder.co.uk ([195.188.213.10]:17439 "EHLO
	smtp-out7.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S262559AbUCJI4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 03:56:39 -0500
Message-ID: <404ED845.7070804@blueyonder.co.uk>
Date: Wed, 10 Mar 2004 08:56:37 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.4-rc2-mm1 lockup with NVIDIA driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Mar 2004 08:56:38.0600 (UTC) FILETIME=[994F3480:01C4067D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SuSE 9.0 Pro on Athlon XP2200+, 2.6.4-rc2-mm1 seemed to cause some 
filesystem corruption with the nvidia driver, using the distributed nv 
driver is OK.
Booted to runlevel 3, installed the latest nvidia 5336 package, init 5 
and video switched to a black screen and there is a hard lockup. No 
problems up to  2.6.3-mm kernels.  Rebooting to 2.6.3-mm4 which had been 
OK now gave a hard lockup.
Did a reiserfsck --rebuild-tree, a number of files fixed, but the 
problem did not go away. Also when starting vi or saving a file edited 
with vi, I get this garbage, the file is however fine.
E575: viminfo: Illegal starting char in line: ADD 3925868551 "def" 
"/apps/gnome-settings/ggv" 
"IOR:01eeffbf1700000049444c3a436f6e6669674c697374656e65723a312e300000030000000054424f580000000101026205000000554e495800000000090000006261727261626173000000002d0000002f746d702f6f726269742d6c616e63656c6f742f6c696e632d6664382d302d3666333639616464376366653100652f7300000000caaedfba58000000010102002d0000002f746d702f6f726269742d6c616e63656c6f742f6c696e632d6664382d302d36663336396164643763666531000000001c00000000000000e8aa2c20e00768a8dc2928282828282804000000ff9f55c101
E575: viminfo: Illegal starting char in line: ADD 3942645768 "def" 
"/apps/ggv/gtkgs" 
"IOR:01eeffbf1700000049444c3a436f6e6669674c697374656e65723a312e300000030000000054424f580000000101020005000000554e495800646573090000006261727261626173007465722d0000002f746d702f6f726269742d6c616e63656c6f742f6c696e632d6664382d302d3666333639616464376366653100652f7300000000caaedfba58000000010102002d0000002f746d702f6f726269742d6c616e63656c6f742f6c696e632d6664382d302d36663336396164643763666531000000001c00000000000000e8aa2c20e00768a8dc2928282828282804000000ff9f55c101000000480
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

