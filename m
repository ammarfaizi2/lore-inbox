Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265096AbUELA2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265096AbUELA2E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 20:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265074AbUELAZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 20:25:00 -0400
Received: from scream.wlv.netzero.net ([209.247.163.9]:58642 "EHLO
	exchange2.wlv.corp.int.untd.com") by vger.kernel.org with ESMTP
	id S265096AbUELAUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 20:20:36 -0400
Message-ID: <746DC3BFE2AFD411AB8D0090279CC7181C06933D@EXCHANGE2.wlv.corp.int.untd.com>
From: Fan Zhang <FZhang@corp.untd.com>
To: linux-kernel@vger.kernel.org
Subject: CBQ shaper does not work for work for first 2 back to back packet
	s
Date: Tue, 11 May 2004 17:22:03 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I setup shaper with CBQ, I found the shaper does not limit traffic for
first two packets. I turned on tcpdump to monitor traffic through Linux
shaper and found that receiver side almost always gets 2 packets at same
time and then gets other packets based on bandwidth and rate setting of CBQ.
I tried maxburst = 1512, minburst = 1512 and they did not work out (1512 is
MTU value).


Could you give me a hint to solve this problem?

Thanks

Fan

   


.
