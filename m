Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWIWVUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWIWVUv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 17:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWIWVUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 17:20:51 -0400
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:37643 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1750704AbWIWVUu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 17:20:50 -0400
Date: Sat, 23 Sep 2006 23:20:54 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Adrian Bunk <bunk@stusta.de>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.30-pre1
Message-Id: <20060923232054.4964f729.khali@linux-fr.org>
In-Reply-To: <1159045077.1097.182.camel@mindpipe>
References: <20060922222300.GA5566@stusta.de>
	<20060922223859.GB21772@kroah.com>
	<20060922224735.GB5566@stusta.de>
	<20060922230928.GB22830@kroah.com>
	<20060923224909.69579243.khali@linux-fr.org>
	<1159045077.1097.182.camel@mindpipe>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

> On Sat, 2006-09-23 at 22:49 +0200, Jean Delvare wrote:
> > I will not use 2.6.16.y with its current rules, for sure, and I doubt
> > any distribution will. Wasn't the whole point of 2.6.16.y to serve as
> > a common base between several distributions? 
> 
> I would not expect distros to be interested in a 2.6 tree that does not
> add support for new devices.  Isn't new hardware support one of the main
> areas where distros routinely get ahead of mainline?

It really depends on the distribution, and even more of the specific
product. I know for a fact that Suse has no interest in supporting
additional hardware in the saa7134 driver for SLES10, for example. I
suspect that distributions only backport hardware support when a
customer asks for it, and they have some in-house knowledge to do it
safely.

My original understanding was that 2.6.16.y was meant to be a common
tree between different distributions and products, containing only the
unquestionable fixes - i.e. security, data corruption and other oopses,
in the -stable spirit - and then different distributions would add their
own patches on top of it as they see fit.

-- 
Jean Delvare
