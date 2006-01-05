Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbWAENS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWAENS4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 08:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbWAENS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 08:18:56 -0500
Received: from mail45.e.nsc.no ([193.213.115.45]:50413 "EHLO mail45.e.nsc.no")
	by vger.kernel.org with ESMTP id S1750920AbWAENSz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 08:18:55 -0500
Subject: 2.6.15-rt1-sr1: xfs mount crash
From: Vegard Lima <Vegard.Lima@hia.no>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 14:20:01 +0100
Message-Id: <1136467202.2310.10.camel@tordenfugl.lima.heim>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I still get an Oops when mounting an XFS filesystem under 2.6.15-rt1-sr1
(Same happend for 2.6.15-rc7-rt1: http://lkml.org/lkml/2005/12/29/67 )

I can make the Oops go away by changing this config option from
  # CONFIG_DEBUG_RT_LOCKING_MODE is not set
to
  CONFIG_DEBUG_RT_LOCKING_MODE=y

Full dmesg output and .config can be found here:
  http://home.hia.no/~vegardl/rt/


Please CC me as I'm not subscribed to the list.
Thanks,
-- 
Vegard Lima <Vegard.Lima@hia.no>


