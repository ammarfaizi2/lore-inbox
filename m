Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263413AbUJ2Qmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263413AbUJ2Qmv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 12:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263407AbUJ2QkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 12:40:20 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:56028 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S263430AbUJ2Qhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 12:37:33 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.10-rc1-mm2: konqueror segfaults for no reason
Date: Fri, 29 Oct 2004 18:23:34 +0200
User-Agent: KMail/1.6.2
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410291823.34175.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2.6.10-rc1-mm2 with SuSE 9.1 /x86_64 konqueror always crashes for no 
specific reason and the following messages appear in dmesg:

local[18494]: segfault at 0000003000000018 rip 0000000000428f2a rsp 
0000007fbfffe870 error 4
local[18493]: segfault at 0000003000000018 rip 0000000000428f2a rsp 
0000007fbfffe870 error 4

This does not happen on 2.6.10-rc1.

The .config is available at:
http://www.sisk.pl/kernel/041029/2.6.10-rc1-mm2.config

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
