Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317797AbSGKJAs>; Thu, 11 Jul 2002 05:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317798AbSGKJAr>; Thu, 11 Jul 2002 05:00:47 -0400
Received: from scaup.mail.pas.earthlink.net ([207.217.120.49]:11495 "EHLO
	scaup.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S317797AbSGKJAr>; Thu, 11 Jul 2002 05:00:47 -0400
Date: Thu, 11 Jul 2002 05:02:14 -0400
To: andrea@suse.de, jamagallon@able.es
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: pipe and af/unix latency differences between aa and jam on smp
Message-ID: <20020711090214.GA16423@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> both pipe and afunix should not generate any irq load (other than
> the IPI with the reschedule_task wakeups at least, but they're only
> dependent on the scheduler

there are some scheduler bits in irqbalance for cpu affinity.
irqbalance is in the two jam patchsets with low latency, and not
in the patchsets with higher latency.  

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

