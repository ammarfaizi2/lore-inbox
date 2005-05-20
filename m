Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbVETJnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVETJnr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 05:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVETJnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 05:43:46 -0400
Received: from ulysses.news.tiscali.de ([195.185.185.36]:29946 "EHLO
	ulysses.news.tiscali.de") by vger.kernel.org with ESMTP
	id S261395AbVETJnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 05:43:43 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Andre Russ <russ@laba9.de>
Newsgroups: linux.kernel
Subject: Promise TX4 { DriveReady SeekComplete Error }
Date: Fri, 20 May 2005 11:43:39 +0200
Organization: Tiscali Germany Usenet
Message-ID: <d6kbem$vs2$1@ulysses.news.tiscali.de>
NNTP-Posting-Host: p213.54.143.199.tisdip.tiscali.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Trace: ulysses.news.tiscali.de 1116582168 32642 213.54.143.199 (20 May 2005 09:42:48 GMT)
X-Complaints-To: abuse@tiscali.de
NNTP-Posting-Date: Fri, 20 May 2005 09:42:48 +0000 (UTC)
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get the following error an my hardware:

May 20 11:28:30 ss1 kernel: ata6: status=0x51 { DriveReady SeekComplete
Error }
May 20 11:28:30 ss1 kernel: ata6: called with no error (51)!
May 20 11:28:32 ss1 kernel: ata6: status=0x51 { DriveReady SeekComplete
Error }
May 20 11:28:32 ss1 kernel: ata6: called with no error (51)!
May 20 11:28:32 ss1 kernel: ata7: status=0x51 { DriveReady SeekComplete
Error }
May 20 11:28:32 ss1 kernel: ata7: called with no error (51)!
May 20 11:28:35 ss1 kernel: ata8: status=0x51 { DriveReady SeekComplete
Error }
May 20 11:28:35 ss1 kernel: ata8: called with no error (51)!
May 20 11:28:43 ss1 kernel: ata5: status=0x51 { DriveReady SeekComplete
Error }
May 20 11:28:43 ss1 kernel: ata5: called with no error (51)!
May 20 11:29:14 ss1 kernel: ata8: status=0x51 { DriveReady SeekComplete
Error }
May 20 11:29:14 ss1 kernel: ata8: called with no error (51)!
May 20 11:29:35 ss1 kernel: ata8: status=0x51 { DriveReady SeekComplete
Error }
May 20 11:29:35 ss1 kernel: ata8: called with no error (51)!
May 20 11:29:35 ss1 kernel: ata8: status=0x51 { DriveReady SeekComplete
Error }
May 20 11:29:35 ss1 kernel: ata8: called with no error (51)!

I am using a Promise TX4 SATAII150 controller. I have the same issue on
multiple hardwares (different boards, different processors). I am very
sure it is not a problem with the cableing or any other part in the box,
because I exchanged every part behind the controller with other parts.
HDD's and cables work excellent on a ICH6.
I tried with the latest stable kerenel (2.6.11.x) and even with the
newer 2.6.12rc4 where ordered flushing was introduced, but it does not
solve the problem.

Any ideas ?

Regards
Andre Russ
