Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWA3JDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWA3JDp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 04:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWA3JDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 04:03:45 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:44204 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932143AbWA3JDo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 04:03:44 -0500
Date: Mon, 30 Jan 2006 10:03:36 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Sam Ravnborg <sam@ravnborg.org>
cc: LKML <linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH RFC] put UTS_RELEASE in separate utsversion.h file
In-Reply-To: <20060128215937.GA14442@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.61.0601301000340.6405@yvahk01.tjqt.qr>
References: <20060128215937.GA14442@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>During the last few days I have been toying with a allmodconfig tree
>and got irritated by all the extra modules being build over and over
>again.

Yes I have noticed that too. It was fine with 2.6.15 - I could compile a 
kernel, move the binary result and the source tree a little around, wrap it 
up in an rpm package, install it elsewhere, and upon changing options in 
.config, it only recompiled the important bits. With 2.6.16-rc1 it seems to 
always rebuild everything. (I doubt CONFIG_NETFILTER_XT_TARGET_CONNMARK 
influences kernel/exit.o!)


Jan Engelhardt
-- 
