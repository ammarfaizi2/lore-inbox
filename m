Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262241AbVCVDVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262241AbVCVDVw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 22:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbVCVDTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 22:19:04 -0500
Received: from smtp816.mail.sc5.yahoo.com ([66.163.170.2]:15224 "HELO
	smtp816.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262329AbVCVDQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 22:16:07 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Patrick McFarland <pmcfarland@downeast.net>
Subject: Re: alsa es1371's joystick functionality broken in 2.6.11-mm4
Date: Mon, 21 Mar 2005 22:15:58 -0500
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <200503201557.58055.pmcfarland@downeast.net> <200503202221.37576.dtor_core@ameritech.net> <200503211958.54094.pmcfarland@downeast.net>
In-Reply-To: <200503211958.54094.pmcfarland@downeast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503212215.58544.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 March 2005 19:58, Patrick McFarland wrote:
> On Sunday 20 March 2005 10:21 pm, Dmitry Torokhov wrote:
> > I could have broken it during my gameport sysfs integration... Although I
> > can't see anything that could cause the breakage. Can I please see your
> > .config?
> 
> Here.
>

Looks good, I was wondering if you had GAMEPORT=m and SND_ENS1371=y.

> For the curious, what was the first kernel to be released that had your sysfs 
> stuff in it?
> 

2.6.11-mm and 2.6.12-rc1. Vanilla 2.6.11 does not have it.

Could you verify that you enabled joystick port on card? What does
"cat /sys/module/snd_ens1371/parameters/joystick_port" show?

-- 
Dmitry
