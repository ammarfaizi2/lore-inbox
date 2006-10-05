Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWJEIFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWJEIFU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 04:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWJEIFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 04:05:20 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:37819 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751191AbWJEIFP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 04:05:15 -0400
Date: Thu, 5 Oct 2006 10:00:19 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andrew Morton <akpm@osdl.org>
cc: Len Brown <lenb@kernel.org>, Len Brown <len.brown@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] Cast removal
In-Reply-To: <20061004221914.0811b28a.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0610050954370.4847@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0610010026050.32229@yvahk01.tjqt.qr>
 <200610042356.03348.len.brown@intel.com> <20061004211259.8274db49.akpm@osdl.org>
 <200610050043.41997.len.brown@intel.com> <20061004221914.0811b28a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> > > I'm okay applying this patch it touches the linux-specific
>> > > drivers/acpi/* files only, no ACPICA files.
>> > 
>> > Why?
>> 
>> Why am I okay with it?
>
>No, I meant why not clean up ACPICA too?

I was about to go through the whole kernel base for anti-casting. Sounds 
like a big task, and probably is. I just did not want to do it all at 
once and send a mega-patch. Instead, a per-directory walk seems best to 
me, and granted, "dispatcher events executer hardware namespace" and all 
the other directories under drivers/acpi/ were supposed to be the next 
to be examined for casts.
    Though if you have problems with that because compiling with ugh, 
old or broken, compilers, be my guest. 
http://www.velocityreviews.com/forums/t313918-void-casting.html
"""If your compiler requires a cast, you are using a C++ compiler."""
Is that the case?



	-`J'
-- 
