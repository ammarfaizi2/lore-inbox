Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269163AbUICHE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269163AbUICHE3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 03:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269263AbUICHE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 03:04:28 -0400
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:17330 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269322AbUICHER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 03:04:17 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: INIT hangs with tonight BK pull (2.6.9-rc1+)
Date: Fri, 3 Sep 2004 02:04:11 -0500
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409030204.11806.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After doing BK pull last night INIT gets stuck in do_tty_hangup after
executing rc.sysinit. Was booting fine with pull from 2 days ago...

Anyone else seeing this?

I suspect pidhash patch because it touched tty_io.c, but I have not tried
reverting it as it is getting too late here... So I apologize in advance
if I am pointing finger at the innocent ;)

-- 
Dmitry
