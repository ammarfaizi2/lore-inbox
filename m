Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275857AbRJBJKf>; Tue, 2 Oct 2001 05:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275859AbRJBJK0>; Tue, 2 Oct 2001 05:10:26 -0400
Received: from mailrelay3.inwind.it ([212.141.54.103]:2264 "EHLO
	mailrelay3.inwind.it") by vger.kernel.org with ESMTP
	id <S275857AbRJBJKR>; Tue, 2 Oct 2001 05:10:17 -0400
Message-Id: <3.0.6.32.20011002111131.02693d90@pop.tiscalinet.it>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Tue, 02 Oct 2001 11:11:31 +0200
To: linux-kernel@vger.kernel.org
From: Lorenzo Allegrucci <lenstra@tiscalinet.it>
Subject: Huge console switching lags
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've experienced huge (4/5 seconds) console switching lags with
2.4.10 running this [1], never seen before with any kernel.
2.4.10-ac2 is even worse, it can take up to 10/20 seconds and longer
to switch from a console to another (CTRL+F1,F2 etc) while running
the beast below:

[1]
#!/bin/sh
bomb(){bomb|bomb&};bomb

Swap is not an issue, you can swapoff -a and still have lags.
I've never seen any console switch lags with any kernel on any load.



-- 
Lorenzo
