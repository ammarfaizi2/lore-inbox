Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261264AbTCTBJD>; Wed, 19 Mar 2003 20:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261284AbTCTBJD>; Wed, 19 Mar 2003 20:09:03 -0500
Received: from [211.167.76.68] ([211.167.76.68]:59845 "HELO soulinfo")
	by vger.kernel.org with SMTP id <S261264AbTCTBJC>;
	Wed, 19 Mar 2003 20:09:02 -0500
Date: Thu, 20 Mar 2003 09:17:44 +0800
From: hugang <hugang@soulinfo.com>
To: linux-kernel@vger.kernel.org
Subject: net driver suspend/resume problem and fix.
Message-Id: <20030320091744.5702baf3.hugang@soulinfo.com>
X-Mailer: Sylpheed version 0.8.10claws13 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
=?ISO-8859-1?Q?=CA=D5=BC=FE=C8=CB=A3=BA: ?= linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all:

  I'm interesting in software suspend. I'm tested the 2.5.64-mm6 kernel.
It really stable. And suspend/resume function also can limit works. When
I use net driver it still can not works. It will Oops. The problem is
xxxx_resume is recalled, To fix it possbile have two ways.

1: add a value in driver private, test it before suspend/resume.
   It will change ~100 files.
2: add a value in driver common.

Can someone tell me which way good is?  Or have other good method.

Thank you.

-- 
Hu Gang / Steve
Email        : huagng@soulinfo.com, linuxbest@sina.com
GPG FinePrint: 4099 3F1D AE01 1817 68F7  D499 A6C2 C418 86C8 610E
Registered Linux User 204016
