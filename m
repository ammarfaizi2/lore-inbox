Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268155AbUIFPdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268155AbUIFPdu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 11:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268156AbUIFPdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 11:33:50 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:11496 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S268155AbUIFPdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 11:33:49 -0400
Message-Id: <5.1.0.14.2.20040906172216.00b1fbe0@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 06 Sep 2004 17:32:43 +0200
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: Re: drivers/cdrom/cdu31a.c broken
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-ID: rf-SQ2ZcoeVlZYKXNf4g1ah8f93idDa7ViXKGsfRyAEE1Y6dirHNkh
X-TOI-MSGID: 9d5925c9-35f7-47d3-b650-f0b50a2aefb0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf scribeth:
 > typo, should be ; instead of :

I wonder how that happened having been signed off by no less
than 4 people ?!  ;-)

Which raises a couple of other questions regarding the
schedule_timeout -> msleep changes:

Is it correct to replace a TASK_INTERRUPTIBLE schedule_timeout
with msleep which is TASK_UNINTERRUPTIBLE ?

Did anyone check if the relevant pieces of code are under control
of a wait queue ?

Margit


