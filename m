Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274965AbTHFWfr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 18:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274966AbTHFWfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 18:35:47 -0400
Received: from miranda.zianet.com ([216.234.192.169]:55049 "HELO
	miranda.zianet.com") by vger.kernel.org with SMTP id S274965AbTHFWff
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 18:35:35 -0400
Message-ID: <3F3182B5.3040301@zianet.com>
Date: Wed, 06 Aug 2003 16:35:33 -0600
From: kwijibo@zianet.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Machine check expection panic
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I decided to try out the new 2.6.0-test2 kernel today but
ran into a problem with booting it.  I narrowed it down to
the machine check expection code.  I get this panic from
the kernel on boot when I have it enabled

CPU0: Machine Check Exception: 0000000000000004
Bank0: f606200000000833 at 0000000000004040
Kernel Panic: CPU context corrupt.

I disabled this option in the kernel and recompiled and everything
went smooth.  I figured maybe there could actually possibly be
something wrong with the CPU but I can boot with RedHat's
2.4.20-19 kernel fine which I *think* includes machine check exception
code.  I have no beef with leaving the exception code out but I figured
someone on this list may want to know. 

Little bit of hardware info:
Tyan 2466 motherboard
2 Athon MP 1200 processors

Steve


