Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271705AbTHIL6Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 07:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272338AbTHIL6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 07:58:25 -0400
Received: from 0x503e3f58.boanxx7.adsl-dhcp.tele.dk ([80.62.63.88]:59272 "HELO
	mail.hswn.dk") by vger.kernel.org with SMTP id S271705AbTHIL6X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 07:58:23 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Henrik Storner <henrik-kernel@hswn.dk>
Newsgroups: linux.kernel
Subject: Re: 2.6.0-test3 cannot mount root fs
Date: Sat, 9 Aug 2003 11:58:17 +0000 (UTC)
Organization: Linux Users Inc.
Message-ID: <bh2nkp$drd$1@ask.hswn.dk>
References: <3F34D0EA.8040006@rogers.com> <3F34D0EA.8040006@rogers.com> <20030809104024.GA12316@gamma.logic.tuwien.ac.at>
NNTP-Posting-Host: osiris.hswn.dk
X-Trace: ask.hswn.dk 1060430297 14189 172.16.10.100 (9 Aug 2003 11:58:17 GMT)
X-Complaints-To: news@ask.hswn.dk
NNTP-Posting-Date: Sat, 9 Aug 2003 11:58:17 +0000 (UTC)
User-Agent: nn/6.6.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In <20030809104024.GA12316@gamma.logic.tuwien.ac.at> Norbert Preining <preining@logic.at> writes:

>On Sam, 09 Aug 2003, gaxt wrote:
>> Try changing in your bootloader root=/dev/hdb1 to root=341

>tried it already with 
>	root=0341
>and 
>	root=341
>on the lilo prompt. No change.

Did you patch up or install the full tree ? I had this problem 
when I patched 2.6.0-test1 -> 2.6.0-test2.

Rebuilding a fully downloaded source tree appears to have fixed
it for me in -test2. Will try -test3 now.
-- 
Henrik Storner <henrik@hswn.dk> 
