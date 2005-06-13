Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVFMSu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVFMSu3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 14:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVFMSu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 14:50:28 -0400
Received: from opersys.com ([64.40.108.71]:22284 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261194AbVFMSsh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 14:48:37 -0400
Subject: network driver disabled interrupts in PREEMPT_RT
From: Kristian Benoit <kbenoit@opersys.com>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 13 Jun 2005 14:45:47 -0400
Message-Id: <1118688347.5792.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I got lots of these messages when accessing the net running
2.6.12-rc6-RT-V0.7.48-25 :

"network driver disabled interrupts: tg3_start_xmit+0x0/0x629 [tg3]"

it seem to come from net/sched/sch_generic.c.

As of the response time I get, it does not seem normal.

Kristian

