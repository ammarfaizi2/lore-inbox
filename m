Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265297AbUETWvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265297AbUETWvy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 18:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265292AbUETWvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 18:51:53 -0400
Received: from lakemtai06.cox.net ([68.1.17.126]:51077 "EHLO
	lakemtai06.cox.net") by vger.kernel.org with ESMTP id S265308AbUETWvk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 18:51:40 -0400
Mime-Version: 1.0 (Apple Message framework v613)
Content-Transfer-Encoding: 7bit
Message-Id: <5A97B381-AAA2-11D8-BDC1-000393ACC76E@mac.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: [2.6] Missing _raw_write_trylock for PPC/SMP
Date: Thu, 20 May 2004 17:12:08 -0400
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The PPC/32 architecture is missing the SMP definition of the 
_raw_write_trylock
function.  I'm not strong enough on PowerPC assembly but it would be 
nice if
someone could write up an implementation for 
linux/include/asm-ppc/spinlock.h

Cheers,
Kyle Moffett

