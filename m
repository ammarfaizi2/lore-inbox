Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266460AbUITMpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266460AbUITMpT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 08:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266473AbUITMpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 08:45:19 -0400
Received: from aun.it.uu.se ([130.238.12.36]:42906 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266460AbUITMpO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 08:45:14 -0400
Date: Mon, 20 Sep 2004 14:45:06 +0200 (MEST)
Message-Id: <200409201245.i8KCj6d3001238@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Thierry.Coutelier@linux.lu, count@theblah.fi
Subject: Re: Freeze on 2.4 kernels.
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Sep 2004 07:46:10 +0300 (EEST), Jussi Hamalainen wrote:
>> The Hardware are Dell PowerEdge with Perc2 or Perc3. We tried with HP
>> servers and have the same problem. We tried different firmware releases
>> for the Perc cards and still no change.
>
>I think I might be experiencing the same problem here with dual-p3
>1.4GHz PE2550 boxes without PERC. We have a bunch of them doing SMTP
>and webmail and every now and then one of them freezes for no
>apparent reason. I don't get _anything_ on the console and nothing in
>the logs.  Haven't tried serial console though.
>
>This isn't a big problem for me since this happens randomly about
>every 9 weeks or so. Since the boxes are in redundant pairs I've just
>shrugged it off as being a general case of piece-of-crap PC hardware.
>I just thought I should add my two cents' worth...

Our PE2650 (dual HT Xeons) used to have frequent lockup problems.
I was asked to look for an NMI watchdog trace, so I enabled the
I/O-APIC watchdog (nmi_watchdog=1). Since then (a year and a half ago)
the box has been rock solid. Currently running FC2 user-space with
the RHEL3 2.4.21-20 kernel.

/Mikael
