Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266808AbUIOQiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266808AbUIOQiA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 12:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266244AbUIOQLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 12:11:08 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:40633 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266708AbUIOQGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 12:06:42 -0400
Subject: Re: 2.6.9 rc2 freezing
From: Lee Revell <rlrevell@joe-job.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Ricky Beam <jfbeam@bluetronic.net>,
       Zilvinas Valinskas <zilvinas@gemtek.lt>,
       Erik Tews <erik@debian.franken.de>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <41486691.3080202@pobox.com>
References: <Pine.GSO.4.33.0409151047560.10693-100000@sweetums.bluetronic.net>
	 <1095263296.2406.141.camel@krustophenia.net>  <41486691.3080202@pobox.com>
Content-Type: text/plain
Message-Id: <1095264408.2406.148.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 15 Sep 2004 12:06:48 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-15 at 11:58, Jeff Garzik wrote:
> Lee Revell wrote:
> > On Wed, 2004-09-15 at 10:55, Ricky Beam wrote:
> > 
> >>On Wed, 15 Sep 2004, Zilvinas Valinskas wrote:
> >>
> >>>Perhaps that is mixture of PREEMPT=y and ipsec ? dunno ...
> >>
> >>No mixture necessary.  PREEMPT is uber-screwed up.  Try rebuilding your
> >>kernel/modules with it disabled. (make clean first; the kernel deps don't
> >>track CONFIG_PREEMPT correctly.)
> > 
> > 
> > Um, PREEMPT works just fine.  Anything that breaks on PREEMPT will also
> > break on SMP.  And the kernel deps do track CONFIG_PREEMPT correctly.
> 
> 
> PREEMPT is a hack.  I do not recommend using it on production servers.
> 

Not every Linux machine is a server.  Just because you can't bang a
square peg through a round hole does not mean the peg is defective.

Anyway, if you are running anything on your server that breaks under
PREEMPT, it will break anyway as soon as you add another processor.

Lee

