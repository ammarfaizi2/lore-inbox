Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265609AbTL3HbZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 02:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265694AbTL3HbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 02:31:25 -0500
Received: from mail2.megatrends.com ([155.229.80.16]:21252 "EHLO
	atl-ms1.megatrends.com") by vger.kernel.org with ESMTP
	id S265609AbTL3HbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 02:31:22 -0500
Message-ID: <8CCBDD5583C50E4196F012E79439B45C0568D7F0@atl-ms1.megatrends.com>
From: Srikumar Subramanian <SrikumarS@ami.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: Srikumar Subramanian <SrikumarS@ami.com>,
       Boopathi Veerappan <BoopathiV@ami.com>
Subject: memory leak in call_usermodehelper()
Date: Tue, 30 Dec 2003 02:32:01 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

>From my customized system call, I merely call call_usermodehelper() to spawn
a process. When I call my_system_call around 1000 times in order to spawn
'hello world' program, I noticed in 'top' program that system has lost 200
KB of free memory.
I just increased the iteration to 700000, I lost the entire 128 MB free
memory from my system and eventually the system is freezed.

Any suggestion or patch to over come this issue ?

Please 'cc' me in your reply.

Thanks & Regards,
Srikumar.
