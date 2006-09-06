Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932586AbWIFGIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932586AbWIFGIK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 02:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932588AbWIFGIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 02:08:09 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:47499 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932586AbWIFGIG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 02:08:06 -0400
Message-ID: <44FE65BF.10703@cn.ibm.com>
Date: Wed, 06 Sep 2006 14:07:59 +0800
From: Yao Fei Zhu <walkinair@cn.ibm.com>
Reply-To: walkinair@cn.ibm.com
Organization: IBM
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: CIFS VFS: No task to wake, unknown frame rcvd! NumMids 15
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi, all,
I run fsstress on CIFS, kernel 2.6.18-rc6, both server and client are in 
same box,
and kernel output lots of info like the following, I don't know
whether it's the expected behaviour.

CIFS VFS: No task to wake, unknown frame rcvd! NumMids 15
 CIFS VFS: Cmd: 50 Err: 0x1f0100c0 Flags: 0x80 Flgs2: 0x41c0 Mid: 31414 
Pid: 23127
 CIFS VFS: smb buf c0000001b01ca990 len 39
 CIFS VFS: Dump pending requests:
 CIFS VFS: State: 2 Cmd: 162 Pid: 22283 Tsk: c0000001bbd40640 Mid 31432
 CIFS VFS: IsMult: 0 IsEnd: 0
 CIFS VFS: State: 2 Cmd: 50 Pid: 23181 Tsk: c0000001bd8a2640 Mid 31433
 CIFS VFS: IsMult: 0 IsEnd: 0
 CIFS VFS: State: 2 Cmd: 50 Pid: 22400 Tsk: c0000001d97d4540 Mid 31434
 CIFS VFS: IsMult: 0 IsEnd: 0
 CIFS VFS: State: 2 Cmd: 50 Pid: 22656 Tsk: c0000001b383c5c0 Mid 31435
 CIFS VFS: IsMult: 0 IsEnd: 0
 CIFS VFS: State: 2 Cmd: 50 Pid: 22889 Tsk: c0000001bd77b5e0 Mid 31436
 CIFS VFS: IsMult: 0 IsEnd: 0
 CIFS VFS: State: 2 Cmd: 7 Pid: 22935 Tsk: c0000001b1216e90 Mid 31437
 CIFS VFS: IsMult: 0 IsEnd: 0
 CIFS VFS: State: 2 Cmd: 50 Pid: 22498 Tsk: c0000001b705b660 Mid 31438
 CIFS VFS: IsMult: 0 IsEnd: 0
 CIFS VFS: State: 2 Cmd: 162 Pid: 22160 Tsk: c0000001d92ce4c0 Mid 31440
 CIFS VFS: IsMult: 0 IsEnd: 0
 CIFS VFS: State: 2 Cmd: 50 Pid: 22723 Tsk: c0000001b444f4e0 Mid 31439
 CIFS VFS: IsMult: 0 IsEnd: 0
 CIFS VFS: State: 2 Cmd: 50 Pid: 22625 Tsk: c0000001b5e9c910 Mid 31441
 CIFS VFS: IsMult: 0 IsEnd: 0
 CIFS VFS: State: 2 Cmd: 0 Pid: 22916 Tsk: c0000001b109f3e0 Mid 31442
 CIFS VFS: IsMult: 0 IsEnd: 0
 CIFS VFS: State: 2 Cmd: 50 Pid: 23078 Tsk: c0000001b01663c0 Mid 31443
 CIFS VFS: IsMult: 0 IsEnd: 0
 CIFS VFS: State: 2 Cmd: 50 Pid: 23096 Tsk: c0000001b03d4040 Mid 31444
 CIFS VFS: IsMult: 0 IsEnd: 0
 CIFS VFS: State: 2 Cmd: 50 Pid: 22515 Tsk: c0000001be2872e0 Mid 31445
 CIFS VFS: IsMult: 0 IsEnd: 0
 CIFS VFS: State: 2 Cmd: 50 Pid: 22362 Tsk: c0000001c1834e90 Mid 31446
 CIFS VFS: IsMult: 0 IsEnd: 0


