Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbWIWPZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWIWPZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 11:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWIWPZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 11:25:59 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:41672 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1751013AbWIWPZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 11:25:58 -0400
Date: Sat, 23 Sep 2006 17:25:17 +0200
From: Voluspa <lista1@comhem.se>
To: ak@muc.de, tglx@linutronix.de, mingo@elte.hu, akpm@osdl.org, pavel@suse.cz,
       brugolsky@telemetry-investments.com, linux-kernel@vger.kernel.org
Subject: Re: hires timer patchset [was Re: 2.6.19 -mm merge plans]
Message-ID: <20060923172517.01ec72b5@loke.fish.not>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.4.13; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

See http://marc.theaimsgroup.com/?l=linux-kernel&m=115897798118500&w=2
for my original report.

I've now built without NO_HZ (but still HIGH_RES_TIMERS) and that fixes
the issue. You've got most of my machine specs since previous, even an
output from dmidecode, but feel free to ask for more if this bug
interests you.

I'm not particularly eager to get it solved... the nvidia driver still
needs one more hack for the glue to build against -rt3.

Mvh
Mats Johannesson
