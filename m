Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbUKWRkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbUKWRkV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 12:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbUKWRix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 12:38:53 -0500
Received: from cantor.suse.de ([195.135.220.2]:4573 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261357AbUKWQqO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 11:46:14 -0500
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: var args in kernel?
References: <Pine.LNX.4.53.0411221155330.31785@yvahk01.tjqt.qr>
	<Pine.LNX.4.53.0411221155330.31785@yvahk01.tjqt.qr>
	<20041122113328.GQ10340@devserv.devel.redhat.com>
	<41A25D53.9050909@tmr.com> <je8y8t8n5t.fsf@sykes.suse.de>
	<Pine.LNX.4.53.0411231504560.28979@yvahk01.tjqt.qr>
	<jehdngwqlt.fsf@sykes.suse.de>
	<Pine.LNX.4.53.0411231716480.5749@yvahk01.tjqt.qr>
From: Andreas Schwab <schwab@suse.de>
X-Yow: If elected, Zippy pledges to each and every American
 a 55-year-old houseboy...
Date: Tue, 23 Nov 2004 17:45:37 +0100
In-Reply-To: <Pine.LNX.4.53.0411231716480.5749@yvahk01.tjqt.qr> (Jan
 Engelhardt's message of "Tue, 23 Nov 2004 17:17:45 +0100 (MET)")
Message-ID: <jesm70v7im.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

>>>>It's not a struct, it's an array (of one element of struct type).  You
>>>>can't assign arrays.
>>>
>>> int callme(const char *fmt, struct { ... } argp[1]) {
>>        struct { ... } dest[1];
>>> 	dest = *argp;
>>> }
>>>
>>> Maybe that way?
>>
>>Maybe you should just try.
>
> I did not say that 'dest' was an array too

But we are talking about va_list, which _is_ an array on some
architectures, and which this thread is all about.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
