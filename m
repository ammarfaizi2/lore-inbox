Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbVEQQjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbVEQQjw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 12:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbVEQQjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 12:39:23 -0400
Received: from tim.rpsys.net ([194.106.48.114]:7056 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S261795AbVEQQjQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 12:39:16 -0400
Message-ID: <038301c55afe$f064ad50$0f01a8c0@max>
From: "Richard Purdie" <rpurdie@rpsys.net>
To: "Brice Goglin" <Brice.Goglin@ens-lyon.org>,
       "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
References: <20050516021302.13bd285a.akpm@osdl.org> <4289B423.7050407@ens-lyon.org>
Subject: Re: 2.6.12-rc4-mm2
Date: Tue, 17 May 2005 17:38:59 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin:
> Cardmgr does not automatically start my pcmcia wireless card anymore.
> orinoco modules are not loaded at all.
> I still can modprobe orinoco_cs to get my wireless to work.
>
> Cardmgr says this when starting:
> cardmgr[27367]: no pcmcia driver in /proc/devices
>
> Is this a feature related to the upcoming deprecation of cardctl ?
> Am I supposed to use pcmcia-utils ?

I also see the above message on the arm pxa zaurus with -mm2. I'm still 
using pcmcia-cs rather than pcmcia-utils. pcmcia+cardmgr works fine in -mm1. 
I'm also not sure if this is by design or not...

Regards,

Richard


