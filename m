Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268036AbUIPMa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268036AbUIPMa0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 08:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268029AbUIPM1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 08:27:49 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:52608 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S267993AbUIPM0e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 08:26:34 -0400
Date: Thu, 16 Sep 2004 14:26:32 +0200
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
X-Mailer: The Bat! (v3.0) UNREG / CD5BF9353B3B7091
Reply-To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
X-Priority: 3 (Normal)
Message-ID: <1072359679.20040916142632@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
CC: kernel@kolivas.org
Subject: [2.6.8.1-ck7-web100] Badness in cfq_sort_rr_list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have just had this:
Badness in cfq_sort_rr_list at drivers/block/cfq-iosched.c:428

[ more of the trace at http://dns.toxicfilms.tv/cfq.txt ]

On a 2.6.8.1 with:
- patch-2.6.8.1-ck7.bz2
- web100-2.5.0-200408311033.tar.gz

I know ck7 uses CFQ as deafult and that web100 touches only tcp stuff.

My .config is here:
http://dns.toxicfilms.tv/config.txt

--
Regards,
Maciej


