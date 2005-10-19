Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751003AbVJSRIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbVJSRIT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 13:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbVJSRIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 13:08:19 -0400
Received: from baldrick.bootc.net ([83.142.228.48]:39348 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S1751003AbVJSRIS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 13:08:18 -0400
Message-ID: <43567D80.3050304@bootc.net>
Date: Wed, 19 Oct 2005 18:08:16 +0100
From: Chris Boot <bootc@bootc.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051014)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Reiser4 lockups (no oops)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've been using Reiser4 on a couple of filesystems to give it a shot, 
and although it has been working fine for a while I've noticed that 
newer versions of the patch cause lockups on my machine. It all started 
when I upgraded to the reiser4-for-2.6.13-1.patch.gz from 
reiser4-for-2.6.12-3.patch.gz, which works fine. I've also tested a 
vanilla 2.6.14-rc4-mm1 which has the same symptoms.

I don't get any OOPSes or BUGs or anything, not on my screen nor on my 
serial console (although I'm not sure I have this working right--I only 
seem to get kernel boot messages). Machine replies to pings but I can't 
SSH, and the watchdog doesn't kick in (hangcheck or w83627hf_wdt) so I 
only notice it's crashed when I wake up in the morning. The crashes seem 
most lilkely to occur in periods of heavy I/O -- large Samba file 
transfers or updatdb do the trick.

Anything I can do to try and track down the issue?

Thanks,
Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/

