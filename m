Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932457AbWCABS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbWCABS1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 20:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbWCABS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 20:18:27 -0500
Received: from sccrmhc14.comcast.net ([204.127.200.84]:59337 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1751367AbWCABS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 20:18:26 -0500
From: kernel-stuff@comcast.net (Parag Warudkar)
To: Andrew Morton <akpm@osdl.org>, Chuck Ebbert <76306.1226@compuserve.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] i386: port ATI timer fix from x86_64 to i386
Date: Wed, 01 Mar 2006 01:18:24 +0000
Message-Id: <030120060118.4989.4404F660000D5FFE0000137D22070210539D0E050B9A9D0E99@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Aug  4 2005)
X-Authenticated-Sender: d2FydWRrYXJAY29tY2FzdC5uZXQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 -------------- Original message ----------------------
From: Andrew Morton <akpm@osdl.org>
> Chuck Ebbert <76306.1226@compuserve.com> wrote:
> >
> >  This fixes the "timer runs too fast" bug on ATI chipsets (bugzilla #3927).
> 

At least HP has released a BIOS update[*] to cure this - It states something to the tune of "Fix system time issues when running under Linux OS".  Not sure which one is the workaround and whether one is needed if other is present! 
Time runs correctly for me without this fix and with the BIOS update.

Parag

[*] http://h10025.www1.hp.com/ewfrf/wc/softwareDownloadIndex?dlc=en&lc=en&os=228&product=461746&lang=en&cc=us&softwareitem=ob-36843-1
