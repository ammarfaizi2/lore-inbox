Return-Path: <linux-kernel-owner+w=401wt.eu-S1751801AbWLOKiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbWLOKiJ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 05:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbWLOKiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 05:38:09 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:37187 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751801AbWLOKiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 05:38:07 -0500
Date: Fri, 15 Dec 2006 11:36:23 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
cc: "Robert P. J. Day" <rpjday@mindspring.com>,
       Zach Brown <zach.brown@oracle.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: lots of code could be simplified by using ARRAY_SIZE()
In-Reply-To: <4581DAB0.2060505@s5r6.in-berlin.de>
Message-ID: <Pine.LNX.4.61.0612151135330.22867@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0612131450270.5979@localhost.localdomain>
 <2F8F687E-C5E5-4F7D-9585-97DA97AE1376@oracle.com>
 <Pine.LNX.4.64.0612141721580.10217@localhost.localdomain>
 <4581DAB0.2060505@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>> Indeed, there seems to be lots of potential clean-up there.
>>> Including duplicate macros like:
>>>
>>> ./drivers/ide/ide-cd.h:#define ARY_LEN(a) ((sizeof(a) / sizeof(a[0])))
>> 
>> not surprisingly, i have a script "arraysize.sh":
>...
>
>This could also come in the flavor "sizeof(a) / sizeof(*a)".
>I haven't checked if there are actual instances.

Even  sizeof a / sizeof *a

may happen.


	-`J'
-- 
