Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbVGSUTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbVGSUTa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 16:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbVGSUTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 16:19:30 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:48015 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261699AbVGSUT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 16:19:28 -0400
Subject: Re: Noob question. Why is the for-pentium4 kernel built with 
	-march=i686 ?
From: Lee Revell <rlrevell@joe-job.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: 7eggert@gmx.de, ivan@yosifov.net, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0507192214100.16157@yvahk01.tjqt.qr>
References: <4s3M3-ph-15@gated-at.bofh.it> <4s4y2-Rt-17@gated-at.bofh.it>
	 <4s5aD-1sw-3@gated-at.bofh.it> <E1DuyS0-00013Z-VG@be1.lrz>
	 <Pine.LNX.4.61.0507192214100.16157@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Tue, 19 Jul 2005 16:19:22 -0400
Message-Id: <1121804362.4299.9.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-19 at 22:15 +0200, Jan Engelhardt wrote:
> >AFAIK it's not possible to use SSE and MME in kernel mode, since these
> >registers aren't preserved (it would be expensive).
> 
> Floating point is anyway a no-no in the kernel. 

However, there are a few exceptions like mmx_memcpy.

Lee

