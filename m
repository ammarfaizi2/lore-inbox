Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbUCEWNL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 17:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbUCEWNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 17:13:11 -0500
Received: from smtp3.poczta.onet.pl ([213.180.130.29]:12479 "EHLO
	smtp3.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S261274AbUCEWNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 17:13:06 -0500
Message-ID: <4048EB33.7030900@poczta.onet.pl>
Date: Fri, 05 Mar 2004 22:03:47 +0100
From: Marcin Garski <garski@poczta.onet.pl>
Reply-To: garski@poczta.onet.pl
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.4.1) Gecko/20031010
X-Accept-Language: pl, en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Data corruption during read on VIA vt8235
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Please CC me on replies, I am not subscribed to the list, thanks]
Hi,

I've Soltek SL-75FRV mainboard (VIA KT400 and vt8235 chipsets).
Also i've two IDE disk both runing on UDMA(100) (DMA enabled).
I'm using 2.4.22 kernel from Fedora Core 1 + patch for XFS suppport.

Several checking md5 sum of big file (650MB) give different results
(e.g: first, second and third* *file check give good md5 sum, but fourth 
check give bad sum).
Also if i copy big file through network (ethernet), file have bits 
difference, the same
thing happen during file copy (also big file) betwen two disks.
Usually there are from 1 to 3 differneces in file, each difference is 
one bit  (e.g good file - 4B, bad file - 4A).

That is not a memory problem because memtest86 shows no errors.

I found some old message:
http://www.ussg.iu.edu/hypermail/linux/kernel/0111.0/0914.html
where author had similar problem to mine.

Could you give me some hints how to more deeply diagnose this problem.
-- 
Best Regards
Marcin Garski
