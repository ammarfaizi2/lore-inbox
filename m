Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbTFGIaR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 04:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbTFGIaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 04:30:17 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:57780 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262771AbTFGIaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 04:30:15 -0400
Message-Id: <5.1.0.14.2.20030607103950.00af14e8@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 07 Jun 2003 10:43:33 +0200
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: Re:[TRIV-PATCH] Better CONFIG_X86_GENERIC description (was:
  Re: Generic x86 support in 2.5.70-bk)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Seen: false
X-ID: Vy1d8ZZeZeluMQyOmSaZhephFniRVg7wBsk5CUAfKH+u4aEWNx4bsp@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, as a side note, looking at arch/i386/Kconfig, the following
looks very suspect :

config X86_L1_CACHE_SHIFT
         int
         default "7" if MPENTIUM4 || X86_GENERIC

Margit

