Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbUBVAug (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 19:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbUBVAug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 19:50:36 -0500
Received: from adsl-63-194-240-129.dsl.lsan03.pacbell.net ([63.194.240.129]:27653
	"EHLO mikef-fw.mikef-fw.matchmail.com") by vger.kernel.org with ESMTP
	id S261635AbUBVAuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 19:50:35 -0500
Message-ID: <4037FCDA.4060501@matchmail.com>
Date: Sat, 21 Feb 2004 16:50:34 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Large slab cache in 2.6.1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually 2.6.1-bk2-nfsd-stalefh-nfsd-lofft (two nfsd patches that 
already made it into 2.6.2 and 2.6.3)

http://www.matchmail.com/stats/lrrd/matchmail.com/srv-lnx2600.matchmail.com-memory.html

I have 1.5 GB of ram in this system that will be a Linux Terminal Server 
  (but using Debian & VNC).  There's 600MB+ anonymous memory, 600MB+ 
slab cache, and 100MB page cache.  That's after turning off swap (it was 
400MB into swap at the time).

Turning off the swap only shrank my page cache, and my slab didn't 
shrink one bit.

I'm sending this email because this is a production server, and I'd like 
to know if any patches after 2.6.1 would help this problem.

Thanks,

Mike

