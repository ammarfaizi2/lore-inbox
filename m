Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313026AbSDJMyB>; Wed, 10 Apr 2002 08:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313038AbSDJMyA>; Wed, 10 Apr 2002 08:54:00 -0400
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:54687 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S313026AbSDJMx6>; Wed, 10 Apr 2002 08:53:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.5.8-pre2: preempt: exits with preempt_count 1
Date: Wed, 10 Apr 2002 14:53:36 +0200
X-Mailer: KMail [version 1.3.2]
Cc: rml@tech9.net
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16vHbV-0000M5-00@baldrick>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My system (x86 K6 UP running 2.5.8-pre2 with preemption) on powering down
gave:

...
Power down.
error: halt[411] exited with preempt_count 1

This was after about 24 hours of up time.  What can I do to help
track down this locking problem?

All the best,

Duncan.
