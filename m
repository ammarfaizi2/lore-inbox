Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276743AbRJ2RMm>; Mon, 29 Oct 2001 12:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276766AbRJ2RMc>; Mon, 29 Oct 2001 12:12:32 -0500
Received: from [195.66.192.167] ([195.66.192.167]:40466 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S276743AbRJ2RM0>; Mon, 29 Oct 2001 12:12:26 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: "linux kernel" <linux-kernel@vger.kernel.org>
Subject: [BUG] Smbfs + preempt on 2.4.10
Date: Mon, 29 Oct 2001 19:12:08 +0000
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01102919120800.05333@nemo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I narrowed down Samba weirdness I observe on 2.4.10 to preempt patch.
Plain 2.4.10 works fine, 2.4.10+preempt (with latency measurement turned on)
is sometimes oopses, and sometimes reports 'file already exists' when I 
attempt to copy a file from WinNT box to Linux. Sometimes it works ok
(50% or so...)

I am very willing to help in curing this coz low latency is great.
Feel free to contact me for any additional info.
--
vda
