Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269610AbUIRS4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269610AbUIRS4w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 14:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269614AbUIRS4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 14:56:52 -0400
Received: from smtp.terra.es ([213.4.129.129]:20678 "EHLO tsmtp4.mail.isp")
	by vger.kernel.org with ESMTP id S269610AbUIRS4v convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 14:56:51 -0400
Date: Sat, 18 Sep 2004 20:56:52 +0200
From: Diego Calleja <diegocg@teleline.es>
To: <Andries.Brouwer@cwi.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hackbench?
Message-Id: <20040918205652.6b4c1d5a.diegocg@teleline.es>
In-Reply-To: <UTC200409181807.i8II7IK06013.aeb@smtp.cwi.nl>
References: <UTC200409181807.i8II7IK06013.aeb@smtp.cwi.nl>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sat, 18 Sep 2004 20:07:18 +0200 (MEST) <Andries.Brouwer@cwi.nl> escribió:

> I was shown results that go in the other direction, so just tried
> on a machine here.

In a 512 MB dual p3 machine I got this: (hackbench 100)

2.4.26: Time: 38.123
2.6.9-rc2-mm1: Time: 19.505

BTW, in the 2.6 case the kernel didn't have a very nice behaviour: A couple of
seconds after starting hackbench(after doing the benchmarks), Xorg stopped
running until hackbench finished. X was using nice 0.
