Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270208AbTGMKYO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 06:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270209AbTGMKYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 06:24:14 -0400
Received: from nice-1-a7-62-147-124-80.dial.proxad.net ([62.147.124.80]:31495
	"EHLO monpc") by vger.kernel.org with ESMTP id S270208AbTGMKYL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 06:24:11 -0400
From: Guillaume Chazarain <gfc@altern.org>
To: linux-kernel@vger.kernel.org
Date: Sun, 13 Jul 2003 12:41:41 +0200
X-Priority: 3 (Normal)
Message-Id: <SO8752FA8VR71YW8IEQOJDXT3Y86D8.3f113765@monpc>
Subject: Re: [RFC][PATCH] SCHED_ISO for interactivity
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
X-Mailer: Opera 6.06 build 1145
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Con,

I am currently testing SCHED_ISO, but I have noticed a regression:
I do a make -j5 in linux-2.5.75/ everything is OK since gcc prio is 25.
X and fvwm prio are 15, but when I move a window it's very jerky.

And btw, as I am interested in scheduler improvements, do you have a testcase
where the stock scheduler does the bad thing? Preferably without KDE nor
Mozilla (I don't have them installed, and I'll have access to a decent
connection in september).

BTW2, you all seem to test interactivity with xmms. Just for those like me
that didn't noticed, I have just found that it skips much less with alsa's
OSS emulation than with alsa-xmms.


Thanks,
Guillaume









