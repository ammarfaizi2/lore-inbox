Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261816AbVFPV5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbVFPV5a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 17:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbVFPV5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 17:57:30 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:39876 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261816AbVFPV50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 17:57:26 -0400
Message-ID: <42B1F5CB.9020308@g-house.de>
Date: Thu, 16 Jun 2005 23:57:31 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Lars Roland <lroland@gmail.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: tg3 in 2.6.12-rc6 and Cisco PIX SMTP fixup
References: <4ad99e0505061605452e663a1e@mail.gmail.com>
In-Reply-To: <4ad99e0505061605452e663a1e@mail.gmail.com>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars Roland schrieb:
> So are there any differences in the tg3 driver between 2.6.8.1 and
> 2.6.12-rc6 that would cause this kind of behaviour ?.

i'd say: "certainly", but best you find out by diff'ing the versions
and/or eventually put 2.6.8.1's tg3 driver in a 2.6.12-rc6 tree, compile,
hope it builds, then try again to connect.

> I know that SMTP fixup is mostly a poorly implemented Sendmail

i don't know what a "smtp fixup" would be, but does the disconnect happen
to other applications too?

if it really turns out to be a tg3 problem, maybe netdev@oss.sgi.com
should be Cc'ed.
-- 
BOFH excuse #67:

descramble code needed from software company
