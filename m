Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbTJDW2S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 18:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbTJDW2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 18:28:18 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:6596 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262792AbTJDW2R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 18:28:17 -0400
Date: Sun, 5 Oct 2003 00:28:09 +0200 (MEST)
Message-Id: <200310042228.h94MS9Zb018316@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: brice@tincell.com, cliffw@osdl.org
Subject: Re: [PATCH] macintosh/adbhid.c REP_DELAY fix (was Re: 2.6.0-test5-stuck keys on iBook)
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Oct 2003 09:40:22 +0200, Brice Figureau <brice@tincell.com> wrote:
>On Tue, 2003-09-30 at 23:31, cliff white wrote:
>> Kernel version: latest from ppc.bkbits.net/linuxppc-2.5/
>> Symptom: keyboard diarrhea - single keypress == 3-7 characters.
>
>Here is a patch that fixes the keyboard problem. The input layer
>REP_DELAY (and REP_PERIOD) were changed from jiffies to ms but the adb
>was not updated accordingly.

Thanks for this patch. It fixed the keyboard problems
my PowerMac had with kernel 2.6.0-test6.

/Mikael
