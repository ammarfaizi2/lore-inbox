Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261594AbTAIFJQ>; Thu, 9 Jan 2003 00:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261600AbTAIFJQ>; Thu, 9 Jan 2003 00:09:16 -0500
Received: from gherkin.frus.com ([192.158.254.49]:1152 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id <S261594AbTAIFJP>;
	Thu, 9 Jan 2003 00:09:15 -0500
Subject: Re: XFree86 vs. 2.5.54 - reboot
In-Reply-To: <3E1C9D9A.FD5CA1F6@digeo.com> "from Andrew Morton at Jan 8, 2003
 01:52:26 pm"
To: Andrew Morton <akpm@digeo.com>
Date: Wed, 8 Jan 2003 23:17:56 -0600 (CST)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20030109051756.7B1134EE7@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy(0000))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Perhaps you should try disabling
> various DRM/AGP type things in config, see if that helps.

All the DRM/AGP stuff was configured as modules, and none of them
were loaded prior to running "startx".  If disabling them entirely
is different from not loading them, I'll be happy to give that a try.

> If not, it would
> help if you could identify the kernel version at which the failure started
> to occur.

Wish I knew for certain...  The 2.5 series got to be unusable from my
perspective somewhere in the 2.5.50 timeframe.  2.5.51 may have worked:
that was the last 2.5 kernel I built prior to 2.5.54.  I didn't run it
as a "production" kernel either because of the X11 problem, or because
the ALSA emu10k1 driver was broken (the latter is fine in 2.5.54 as far
as I can tell).

2.5.55 is out.  Maybe I should give that a try.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
