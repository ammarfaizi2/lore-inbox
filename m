Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265338AbTFMKin (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 06:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265339AbTFMKin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 06:38:43 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:40143 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S265338AbTFMKil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 06:38:41 -0400
Date: Fri, 13 Jun 2003 11:52:24 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: mattdm@mattdm.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: cpufreq on Pentium M
Message-ID: <20030613105224.GA21277@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>, mattdm@mattdm.org,
	linux-kernel@vger.kernel.org
References: <20030612042011$03c0@gated-at.bofh.it> <20030612062010$3dad@gated-at.bofh.it> <20030612193016$6d05@gated-at.bofh.it> <20030612193015$7974@gated-at.bofh.it> <20030613024549.078A4720B1@jadzia.bu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030613024549.078A4720B1@jadzia.bu.edu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 10:45:49PM -0400, Matthew Miller wrote:

 > Hi Dave. This is the output from my Celeron 600A system -- it's a tiny bit
 > different from what others posted to the list (an 0x86 instead of an 0x87).
 > My understanding is that this CPU has half the L2 cache of the "real"
 > Pentium M. Hope this is helpful and not annoying.

Yeah, I'd realised that was also missing. I'll get it in sync with 2.5
after Marcelo makes a 2.4.21

 > Also, a question: I had
 > assumed that the lack of info in /proc/cpuinfo was simply that an
 > informational problem, and that the cache is actually working. Am I
 > mistaken? (I.e. will having the kernel support this be a huge performance
 > increase?) Thanks!

performance-wise, it may make a small difference on SMP systems, as it
affects the balancing of the scheduler. On UP, shouldn't be any difference.

		Dave

