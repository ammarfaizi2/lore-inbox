Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbUKWPLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbUKWPLT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 10:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbUKWPI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 10:08:59 -0500
Received: from news.suse.de ([195.135.220.2]:50357 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261282AbUKWPIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 10:08:00 -0500
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Bill Davidsen <davidsen@tmr.com>, Jakub Jelinek <jakub@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: var args in kernel?
References: <Pine.LNX.4.53.0411221155330.31785@yvahk01.tjqt.qr>
	<Pine.LNX.4.53.0411221155330.31785@yvahk01.tjqt.qr>
	<20041122113328.GQ10340@devserv.devel.redhat.com>
	<41A25D53.9050909@tmr.com> <je8y8t8n5t.fsf@sykes.suse.de>
	<Pine.LNX.4.53.0411231504560.28979@yvahk01.tjqt.qr>
From: Andreas Schwab <schwab@suse.de>
X-Yow: As President I have to go vacuum my coin collection!
Date: Tue, 23 Nov 2004 16:07:58 +0100
In-Reply-To: <Pine.LNX.4.53.0411231504560.28979@yvahk01.tjqt.qr> (Jan
 Engelhardt's message of "Tue, 23 Nov 2004 15:05:21 +0100 (MET)")
Message-ID: <jehdngwqlt.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

>>> Why can't you do dest=src? Assignment of struct to struct has been a part
>>> of C since earliest times.
>>
>>It's not a struct, it's an array (of one element of struct type).  You
>>can't assign arrays.
>
> int callme(const char *fmt, struct { ... } argp[1]) {
        struct { ... } dest[1];
> 	dest = *argp;
> }
>
> Maybe that way?

Maybe you should just try.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
