Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266807AbUIORxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266807AbUIORxP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 13:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267184AbUIORvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 13:51:32 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:55502 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266708AbUIORtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 13:49:12 -0400
Subject: Re: 2.6.9 rc2 freezing
From: Lee Revell <rlrevell@joe-job.com>
To: Ricky Beam <jfbeam@bluetronic.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, Zilvinas Valinskas <zilvinas@gemtek.lt>,
       Erik Tews <erik@debian.franken.de>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.33.0409151255240.10693-100000@sweetums.bluetronic.net>
References: <Pine.GSO.4.33.0409151255240.10693-100000@sweetums.bluetronic.net>
Content-Type: text/plain
Message-Id: <1095270555.2406.154.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 15 Sep 2004 13:49:16 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-15 at 12:58, Ricky Beam wrote:
> On Wed, 15 Sep 2004, Jeff Garzik wrote:
> >Lee Revell wrote:
> >> Anyway, if you are running anything on your server that breaks under
> >> PREEMPT, it will break anyway as soon as you add another processor.
> >
> >Incorrect.  The spinlock behavior is very different.
> 
> Indeed.  Enable PREEMPT (my default for some time now) and the machine
> will lockup after spewing pages of scheduling while atomic's.  Disable
> PREEMPT and the machine is stable again:
> 

Interesting.  Still, this looks like a specific bug that needs fixing,
it doesn't imply that preemption is a hack.  For many workloads
preemption is a necessity.

Lee 

