Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262214AbUCEF2W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 00:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbUCEF2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 00:28:22 -0500
Received: from [63.161.72.3] ([63.161.72.3]:45469 "EHLO
	mail.standardbeverage.com") by vger.kernel.org with ESMTP
	id S262214AbUCEF2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 00:28:20 -0500
Message-ID: <950c9d8cf6fbb225c867dff9a4284d0c@stdbev.com>
Date: Thu,  4 Mar 2004 23:33:16 -0600
From: "Jason Munro" <jason@stdbev.com>
Subject: Re: ACPI battery info failure after some period of time, 2.6.3-x and up
To: linux-kernel@vger.kernel.org
Reply-to: <jason@stdbev.com>
In-Reply-To: <Pine.LNX.4.58.0403051259480.387@boston.corp.fedex.com>
References: <4047756D.2050402@blue-labs.org>
            <200403051520.40341.sgy-lkml@amc.com.au>
            <4048015D.6070308@blue-labs.org>
            <200403051543.04300.sgy-lkml@amc.com.au>
            <Pine.LNX.4.58.0403051259480.387@boston.corp.fedex.com>
X-Mailer: Hastymail 1.0-rc1-CVS
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:02 pm Mar 4 Jeff Chua <jeffchua@silk.corp.fedex.com> wrote:
>
> On Fri, 5 Mar 2004, Stuart Young wrote:
>
> >  ...and it just failed then, using 2.6.4-rc2 still.

root@jackass /proc/acpi/battery/BAT1# watch -n 1 'cat ./state'

Over 30 minutes running and still looks fine. I use the GKACPI Gkrellm
plugin which polls the battery status every 30 seconds I beleive. Since
this started I have gone up to 2 + days uptime without it being triggered,
but sometimes its less.

> have you tried applying patch from ...
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release
> /2.6.4/
> acpi-20040220-2.6.4.diff.bz2

The 2.6.3 patch from the same release day does not apply cleanly with the
wolk patchset in place :/ I will try the latest with this patch and see
what happens.


\__ Jason Munro
 \__ jason@stdbev.com
  \__ http://hastymail.sourceforge.net/


