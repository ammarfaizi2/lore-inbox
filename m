Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWBRFgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWBRFgW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 00:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbWBRFgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 00:36:22 -0500
Received: from mtiwmhc12.worldnet.att.net ([204.127.131.116]:31382 "EHLO
	mtiwmhc12.worldnet.att.net") by vger.kernel.org with ESMTP
	id S1750822AbWBRFgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 00:36:21 -0500
Message-ID: <43F6B24E.9080007@lwfinger.net>
Date: Fri, 17 Feb 2006 23:36:14 -0600
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: TKIP: replay detected: WTF?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Feb 17 18:39:36 localhost kernel: TKIP: replay detected: STA=00:13:46:16:96:b8 previous TSC
 > ffff80723500 received TSC 000000000019
 >
 > This is with the various 2.6.16-rc*-git* kernels, and possibly older 2.6.15 series as well.
 > They always seem to arrive in large bursts, like the bunch shown above. Using wifi
 > over ipw2200 to a WPA2 AP.
 >
 > Either this is "normal" behaviour, in which case the code should NOT be spamming me,
 > or something is broken, in which case.. what?

I have been getting similar messages; however, my previous TSC is almost always equal to the 
received TSC. I'm using the alpha bcm43xx driver with softmac, and thought it was a problem with the 
new code. Maybe not. Hmm.

Larry

