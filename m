Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264011AbUDOPkO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 11:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264317AbUDOPkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 11:40:14 -0400
Received: from ns.caseta.com ([68.160.74.213]:14814 "EHLO mailhost.caseta.com")
	by vger.kernel.org with ESMTP id S264011AbUDOPkL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 11:40:11 -0400
Message-ID: <81C5E83694ADD211ACB50000C02F79D703B735D9@eagle.caseta.com>
From: Sergey Lapin <slapin@caseta.com>
To: linux-kernel@vger.kernel.org
Subject: multithreaded coredump in 2.6
Date: Thu, 15 Apr 2004 11:40:46 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have run into problem of getting multithreaded coredumps. All I am getting
is core file which under gdb shows only one thread out of my around 300
threads.

My original installation is RedHat 8.0 (kernel 2.4.18). I have browsed
Internet and found that it supposed to be fixed since 2.5.47. I have
installed 2.6.5 kernel but still get the same one-threaded dump.
I use GDB version 5.2.

What's wrong? Am I missing something? May be I should change some 
kernel settings to enable kernel dump all threads?

I will appreciate any help.
Thanks,
Sergey Lapin
