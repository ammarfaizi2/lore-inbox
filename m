Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264879AbTLFAG0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 19:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbTLFAG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 19:06:26 -0500
Received: from ns.suse.de ([195.135.220.2]:45763 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264879AbTLFAGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 19:06:24 -0500
To: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Large-FAT32-Filesystem Bug
References: <3FD0555F.5060608@gmx.de> <20031205160746.GA18568@codepoet.org>
	<3FD0C64D.5050804@gmx.de> <20031205221051.GA3244@codepoet.org>
	<20031205224529.GS29119@mis-mike-wstn.matchmail.com>
	<yw1x65gu3kyp.fsf@kth.se>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I have seen these EGG EXTENDERS in my Supermarket..
 ..  I have read the INSTRUCTIONS...
Date: Sat, 06 Dec 2003 01:04:03 +0100
In-Reply-To: <yw1x65gu3kyp.fsf@kth.se> (
 =?iso-8859-1?q?M=E5ns_Rullg=E5rd's_message_of?= "Sat, 06 Dec 2003 00:26:22
 +0100")
Message-ID: <jewu9add70.fsf@sykes.suse.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mru@kth.se (Måns Rullgård) writes:

> Mike Fedyk <mfedyk@matchmail.com> writes:
>
>>> No problem.  I put this patch together quite a while ago for
>>> my own use and never got around to sending it in.  It removes
>>> a number of artificial fat32 limits, and allows files up to 4GB,
>>
>> Why only 4gb?
>
> That's what the 32 in fat32 means.

No, it doesn't.  It's about the number of bits in a cluster number, thus
the size of the filesystem.  And that 32 is actually 28.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
