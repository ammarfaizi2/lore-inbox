Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265153AbTLMQMS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 11:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265169AbTLMQMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 11:12:18 -0500
Received: from real-outmail.cc.huji.ac.il ([132.64.1.17]:2190 "EHLO
	mail1.cc.huji.ac.il") by vger.kernel.org with ESMTP id S265153AbTLMQMR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 11:12:17 -0500
Message-ID: <3FDB2B95.3020703@mscc.huji.ac.il>
Date: Sat, 13 Dec 2003 17:09:09 +0200
From: Voicu Liviu <pacman@mscc.huji.ac.il>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en, he
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.23-aa1 AND LVM usage
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm a LVM user and currently running kernel 2.4.23 (vanilla).
At once I decided my self that I want to try 2.6-test11 so I removed 
lvm-use tools, instead of it I installed lvm2 and also installed 
2.6-test11 kernel.

I liked the 2.6 kernel but somehow 2.4.23 worked better with my new 
system (nforce2 chip and sound)...so I wanted to go back to 2.4.23(aa1 
sources) so at this stage I removed lvm2 and installed lvm-user.
Since this step I can not mount my lvm anymore, it says soemthing like:

devs_register(lv_usr): could not append to parent, err: -17
(4 lines line this for every lvm partition)

and also:
error copying : /lib/dev-state/VG/lv_usr to /dev/VG/lv_usr

Any 1 does not know what could be the source of this issue?

Best regards.
Liviu

