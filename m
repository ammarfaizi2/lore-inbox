Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263740AbUGHVPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263740AbUGHVPp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 17:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbUGHVPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 17:15:45 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:29315 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S263740AbUGHVPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 17:15:44 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: linux-kernel@vger.kernel.org
Subject: 2.6.7-mm6: system hang with KAMix on dual Opteron w/ NUMA
Date: Thu, 8 Jul 2004 23:24:55 +0200
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407082324.55181.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've just discovered that I'm (consistently) able to hang the system solid by 
trying to adjust the sound volume using KAMix on 2.6.7-mm6 (SuSE 9.1/ AMD64).  
This problem does not occur on 2.6.7-mm5, so it's been introduced recently, 
it appears.

Unfortunately, I'm unable to get any oops etc. from the kernel, even on the 
serial console (it only prints four spaces and hangs).  I can only say it's 
unrelated to CONFIG_DEBUG_SLAB (it occurs with CONFIG_DEBUG_SLAB on and off).

The system is a dual Opteron w/ NUMA w/o kernel preemption (hardware info log 
and kernel config attached).

Yours,
rjw

-- 
Rafael J. Wysocki
----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
