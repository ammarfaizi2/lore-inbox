Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266274AbUJATpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266274AbUJATpc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 15:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266324AbUJAToD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 15:44:03 -0400
Received: from deepthot.org ([68.14.232.127]:23445 "EHLO dent.deepthot.org")
	by vger.kernel.org with ESMTP id S266274AbUJATl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 15:41:27 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: denebeim@deepthot.org (Jay Denebeim)
Newsgroups: linux.kernel
Subject: Re: system clock...
Date: Fri, 1 Oct 2004 19:41:16 +0000 (UTC)
Organization: deep thought
Message-ID: <cjkbss$kkb$1@dent.deepthot.org>
References: <2KzRy-1BD-13@gated-at.bofh.it>
NNTP-Posting-Host: dent.deepthot.org
X-Trace: dent.deepthot.org 1096659676 21131 192.168.12.1 (1 Oct 2004 19:41:16 GMT)
X-Complaints-To: news@deepthot.org
NNTP-Posting-Date: Fri, 1 Oct 2004 19:41:16 +0000 (UTC)
Originator: denebeim@deepthot.org (Jay Denebeim)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Hopefully this will work, I haven't posted to the LKML with this
configuration.)

In article <2KzRy-1BD-13@gated-at.bofh.it>,
Ankit Jain  <ankitjain1580@yahoo.com> wrote:

>whenever i reboot or start my system my clock is
>incremented by around 6 hrs. after that its alright
>i.e if i correct the time it dosent mis behave but i
>dont know whats wrong in reboot or booting the sys?
>
>if somebody can help or faced this kinda situation?

This is one of two things.  First off, are you sure you're updating
the CMOS clock as part of your reboot process?  During initialization
the system reads the CMOS clock, so if you don't keep it updated the
time will always be incorrect.  You might want to look at the clock
from your BIOS to see what time it is.

The second issue is time zone.  Unless you have a dual boot system
this probably isn't an issue though.  If you have your CMOS clock set
to UTC and you use and unadulterated Windows then every time you boot
the other operating system your clock will be wrong.  Since you appear
to live in Italy though you shouldn't be at UTC +/- 6 hours, so this
is probably not the problem.

Hope this helps
Jay
-- 
* Jay Denebeim  Moderator       rec.arts.sf.tv.babylon5.moderated *
* newsgroup submission address: b5mod@deepthot.org                *
* moderator contact address:    b5mod-request@deepthot.org        *
* personal contact address:     denebeim@deepthot.org             *
