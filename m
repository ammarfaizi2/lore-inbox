Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263089AbUDTPoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263089AbUDTPoX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 11:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbUDTPoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 11:44:23 -0400
Received: from mail.mellanox.co.il ([194.90.237.34]:490 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S263093AbUDTPoW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 11:44:22 -0400
Message-ID: <408545AA.6030807@mellanox.co.il>
Date: Tue, 20 Apr 2004 18:45:46 +0300
From: Eli Cohen <mlxk@mellanox.co.il>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sysrq shows impossible call stack
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am exsperiencing a hang, probably caused by a deadlock, so I can do 
sysrq commands. However I can see that in some cases the exspected call 
stack has some functions in between as if two call stack are 
interleaved. For example, if A and B denote two possible paths, I may see:
A0
A1
B0
A2
B1

Does anyone can explain that?
thanks
Eli
