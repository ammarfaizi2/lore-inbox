Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266578AbUIOPve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266578AbUIOPve (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 11:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266526AbUIOPtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 11:49:14 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:61876 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266498AbUIOPsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 11:48:10 -0400
Subject: Re: 2.6.9 rc2 freezing
From: Lee Revell <rlrevell@joe-job.com>
To: Ricky Beam <jfbeam@bluetronic.net>
Cc: Zilvinas Valinskas <zilvinas@gemtek.lt>,
       Erik Tews <erik@debian.franken.de>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.33.0409151047560.10693-100000@sweetums.bluetronic.net>
References: <Pine.GSO.4.33.0409151047560.10693-100000@sweetums.bluetronic.net>
Content-Type: text/plain
Message-Id: <1095263296.2406.141.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 15 Sep 2004 11:48:16 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-15 at 10:55, Ricky Beam wrote:
> On Wed, 15 Sep 2004, Zilvinas Valinskas wrote:
> >Perhaps that is mixture of PREEMPT=y and ipsec ? dunno ...
> 
> No mixture necessary.  PREEMPT is uber-screwed up.  Try rebuilding your
> kernel/modules with it disabled. (make clean first; the kernel deps don't
> track CONFIG_PREEMPT correctly.)

Um, PREEMPT works just fine.  Anything that breaks on PREEMPT will also
break on SMP.  And the kernel deps do track CONFIG_PREEMPT correctly.

Maybe you are doing it wrong.

Lee

