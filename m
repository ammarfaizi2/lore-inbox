Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131517AbRAVPxi>; Mon, 22 Jan 2001 10:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132216AbRAVPx2>; Mon, 22 Jan 2001 10:53:28 -0500
Received: from concorde.inria.fr ([192.93.2.39]:38788 "EHLO concorde.inria.fr")
	by vger.kernel.org with ESMTP id <S131517AbRAVPxL>;
	Mon, 22 Jan 2001 10:53:11 -0500
From: Alan Schmitt <alan.schmitt@inria.fr>
Date: Mon, 22 Jan 2001 16:51:41 +0100
To: linux-kernel@vger.kernel.org
Subject: kapm-idled and cpu heating ...
Message-ID: <20010122165141.A2888@alan-schm1p.inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Organization: INRIA Rocquencourt 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've read the december thread, I've searched the web and I could not
come out with an answer, so here I dare to ask (please cc me for any
answer as I am not subscribed to the list, I just read the kernel
cousin version).

I just installed 2.4.0 on my laptop (dell cpi a366x). I noticed the
kapm-idled process, which doesn't really bother me, with one
exception: my cpu is getting hot enough to start the fan, even without
any load. I compiled with the apm cpu idle option (here is a quick
grep of my .config file):

[schmitta@alan-schm1p linux]$ grep APM .config
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

This behaviour, with the same options, does not occur with 2.2.18.

So my question is: how idle is kapm-idled ? Is my bios buggy ? Did I
miss something when configuring the kernel ? Is this a really stupid
question ;-)

Thanks for any hint.

Alan Schmitt

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
