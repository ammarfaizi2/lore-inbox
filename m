Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272674AbTG1Gpp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 02:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272678AbTG1Gpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 02:45:45 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:45217
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272674AbTG1Gpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 02:45:43 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] sched-2.6.0-test1-G6, interactivity changes
Date: Mon, 28 Jul 2003 17:05:01 +1000
User-Agent: KMail/1.5.2
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0307271535590.22937-100000@localhost.localdomain> <5.2.1.1.2.20030728065857.01bc9708@pop.gmx.net>
In-Reply-To: <5.2.1.1.2.20030728065857.01bc9708@pop.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307281705.01471.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jul 2003 16:04, Mike Galbraith wrote:
> to recharge his sleep_avg.  He stays low priority.  Kobiashi-maru:  X can't

> Conclusion accuracy/inaccuracy aside, I'd like to see if anyone else can
> reproduce that second scenario.

Yes I can reproduce it, but we need the Kirk approach and cheat. Some 
workaround for tasks that have fallen onto the expired array but shouldn't be 
there needs to be created. But first we need to think of one before we can 
create one...

Con

