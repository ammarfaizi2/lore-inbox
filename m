Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030305AbVHKNtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbVHKNtb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 09:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030306AbVHKNtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 09:49:31 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:25794 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1030305AbVHKNtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 09:49:31 -0400
Message-ID: <42FB5768.8070608@daveking.com>
Date: Thu, 11 Aug 2005 09:49:28 -0400
From: David King <dave@daveking.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Pls help me understand this MCE
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm new at this so I'm learning my way through it and I'd appreciate any
guidance.  My system freezes solid intermittently for no apparent
reason.  The serial console shows a kernal panic caused by a machine
check exception.  mcelog decodes the MCE as follows:

CPU 0 4 northbridge TSC f03d1e587b
Northbridge Watchdog error
bit57 = processor context corrupt
bit61 = error uncorrected
bus error 'generic participation, request timed out
generic error mem transaction
generic access, level generic'
STATUS b200000000070f0f MCGSTATUS 4

That's all meaningless to me so I'm looking for help understanding what
it means and what parts of my system I should be looking at in order to
try to resolve this MCE.

A Google search found one hit that suggested that "Something tried to
access a physical memory address that was not mapped in the CPU."  If
that is indeed the correct interpretation, is there any wany to figure
out what that "something" is?

The system in question is a no-name system built from parts by a local
computer shop.  It has an ASUS A8N-SLI motherboard.  I have updated the
BIOS to the latest without affecting this problem.  The CPU installed is
an "AMD Athlon(tm) 64 Processor 3500+".  I am running Fedora Core 4,
kernel 2.6.12-1.1398_FC4.

Any guidance would be appreciated.

-- 
David King
dave@daveking.com
