Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWAUPO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWAUPO5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 10:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWAUPO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 10:14:57 -0500
Received: from aeimail.aei.ca ([206.123.6.84]:2777 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S1750769AbWAUPO4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 10:14:56 -0500
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc1-mm2
Date: Sat, 21 Jan 2006 10:14:43 -0500
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060120031555.7b6d65b7.akpm@osdl.org> <43D170CB.8080802@reub.net>
In-Reply-To: <43D170CB.8080802@reub.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200601211014.44041.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>From my perspective 2.6.16-rc1-mm2 still needs work.  I did not try 15-mm1 or mm2.  Both
mm3 and mm4 had X problems in that the system would lock but the keyboard was still
active for Sysrq.  The lockups took days to occur on both mm3 and mm4.  The reiser3 problem
made it impossible to test rc1-mm1, rc2-mm2 locked hard sometime in the first 4 hours of 
use - this time sysrq was dead too.  

The system is a amd64 using x86_64 from the unofficial debian build.  The box is stable using
15-rc5-mm3 which has had uptimes of over two weeks.

If anyone has ideas on what to backout let me know.  Failing that I will boot with a serial console
active and see that it reports.

Ideas,
Ed Tomlinson
