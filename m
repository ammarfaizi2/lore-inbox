Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbUKGNnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbUKGNnD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 08:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbUKGNnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 08:43:03 -0500
Received: from i216230.ppp.asahi-net.or.jp ([61.125.216.230]:30863 "EHLO
	zeta.miyonet.org") by vger.kernel.org with ESMTP id S261615AbUKGNnA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 08:43:00 -0500
Date: Sun, 07 Nov 2004 22:42:28 +0900 (JST)
Message-Id: <20041107.224228.846935770.kaz@earth.email.ne.jp>
To: liudeyan@gmail.com
Cc: taka@valinux.co.jp, jimtabor@adsl-64-217-116-74.dsl.hstntx.swbell.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]tar filesystem for 2.6.10-rc1-mm3(easily access tar
 file)
From: Kazuto MIYOSHI <kaz@earth.email.ne.jp>
In-Reply-To: <20041107.172838.74752953.taka@valinux.co.jp>
	<aad1205e0411062306690c21f8@mail.gmail.com>
References: <418DCB2F.2030303@adsl-64-217-116-74.dsl.hstntx.swbell.net>
	<aad1205e041106233274e78428@mail.gmail.com>
	<20041107.172838.74752953.taka@valinux.co.jp>
X-Mailer: Mew version 4.0.54 on XEmacs 21.4.8 (Honest Recruiter)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I am surprised that good old thing is appearing on 2.6 :-)
Hirokazu already pointed out some issues, and my major concern for
the code is that tar archiving mechanism is duplicated (embedded)
into the kernel directly.

BTW, have you looked at LUFS? (Linux Userland Filesystem)
I have not look at it closely, but it sounds it may help you.

Best Regards,
--
Kazuto Miyoshi   kaz@earth.email.ne.jp
