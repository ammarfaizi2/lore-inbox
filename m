Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWEEPav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWEEPav (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 11:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751566AbWEEPav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 11:30:51 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:1511 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751147AbWEEPau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 11:30:50 -0400
Subject: -rt issue with AMD64
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Free@64studio.com,
       daniel@64studio.com
Content-Type: text/plain
Date: Fri, 05 May 2006 11:30:48 -0400
Message-Id: <1146843049.20878.14.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At LAC we discovered that with 2.6.16-rt*, CONFIG_PREEMPT_NONE,
CONFIG_PREEMPT_HARDIRQS=y, and CONFIG_PREEMPT_SOFTIRQS=y with x86_64 is
a valid combination, but the machine immediately shuts down on boot
(before Uncompressing Linux even appears).

Are these likely to be related, or is the problem likely to be somewhere
else?

Lee

