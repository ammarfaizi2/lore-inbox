Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbTJDMGb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 08:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbTJDMGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 08:06:31 -0400
Received: from zeus.colocall.net ([62.149.2.1]:8975 "EHLO colocall.net")
	by vger.kernel.org with ESMTP id S261996AbTJDMGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 08:06:30 -0400
Date: Sat, 4 Oct 2003 15:06:25 +0300
From: "Max A. Krasilnikov" <pseudo@colocall.net>
To: linux-kernel@vger.kernel.org
Subject: reiserfs one user DoS?
Message-ID: <20031004120625.GA41175@colocall.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i.nntp (FreeBSD 4.8-RELEASE-p1 i386)
Organization: Internet Data Center "ColoCALL"
X-Verify-Sender: verified
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
I have found such strange thing:

pseudo@avalon at 14:04:00  ~> dd if=/dev/zero of=file bs=1 count=0 seek=1000000000000

After that my Intel Celeron 800 MHz/384M RAM 60G/Seagate U6 under
Linux-2.4.22-grsec on reiserfs was utilized 100% for more than 2 hours.
dd process can't be killed.

Is this my flow or real bug?

-- 
WBR, Max A. Krasilnikov
"Colocall" Internet Data Center

