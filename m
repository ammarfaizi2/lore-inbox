Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265777AbUGDVIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265777AbUGDVIr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 17:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265781AbUGDVIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 17:08:47 -0400
Received: from agminet02.oracle.com ([141.146.126.229]:59542 "EHLO
	agminet02.oracle.com") by vger.kernel.org with ESMTP
	id S265777AbUGDVIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 17:08:30 -0400
Message-ID: <40E87277.4040206@oracle.com>
Date: Sun, 04 Jul 2004 23:11:19 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040323
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: TCP window scaling still bad in 2.6.7-bk17
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a tcpdump and a description of what happens here

http://xoomer.virgilio.it/incident/tcpdump.out

with www.kernel.org, but I'm mostly shut off the entire 'net.

The _only_ site I found I can browse without disabling TCP
  window scaling is http://www.google.it.


My system:

  RedHat 9 base distro
  2.6.7-bk17 plus ACX100 out-of-kernel wireless driver (version
   0.2.0-pre8_plus_fixes_13) from acx100.sf.net
  built with binutils 2.15.91.0.1 and GCC 3.4.0

System behaved properly until 2.6.7-bk1, was bad since 2.6.7-bk7
  (haven't tried in-between kernels as I was on holiday).

I also tried walking up to my router and connecting via eth0
  instead of wlan0 (to rule out the wireless driver) - still the
  connection to www.kernel.org hangs (always -bk17).


I'm available for further digging, please CC: me on replies as I
  only read lkml from the USSG archives.


Thanks,

--alessandro

  "Practice is more important than theory. A _lot_ more important."
     (Linus Torvalds on lkml, 1 June 2004)


