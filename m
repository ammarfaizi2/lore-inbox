Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265093AbTA2HoX>; Wed, 29 Jan 2003 02:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265094AbTA2HoX>; Wed, 29 Jan 2003 02:44:23 -0500
Received: from fmr01.intel.com ([192.55.52.18]:47102 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S265093AbTA2HoW>;
	Wed, 29 Jan 2003 02:44:22 -0500
Date: Wed, 29 Jan 2003 15:50:44 +0800 (CST)
From: Stanley Wang <stanley.wang@linux.co.intel.com>
X-X-Sender: stanley@manticore.sh.intel.com
To: Scott Murray <scottm@somanetworks.com>
cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PCI_Hot_Plug_Discuss <pcihpd-discuss@lists.sourceforge.net>
Subject: [RFC] Enhance CPCI Hot Swap driver
Message-ID: <Pine.LNX.4.44.0301291538190.10354-100000@manticore.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Scott,
After reading your CPCI Hot Swap support codes, I have a suggestion
to enhance it:
How about to make it be full hot swap compliant?
I mean we could also do some works like "disable_slot" when we receive
the #ENUM & EXT signal. Hence the user could yank the hot swap board 
without issuing command on the console.
How do you think about it?

Cheers,
-Stan
-- 
Opinions expressed are those of the author and do not represent Intel
Corporation


