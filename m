Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263402AbTDSPwZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 11:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263407AbTDSPwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 11:52:25 -0400
Received: from mail.ithnet.com ([217.64.64.8]:39181 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263402AbTDSPwY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 11:52:24 -0400
Date: Sat, 19 Apr 2003 18:04:21 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Are linux-fs's drive-fault-tolerant by concept?
Message-Id: <20030419180421.0f59e75b.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

after shooting down one of this bloody cute new very-big-and-poor IDE drives
today I wonder whether it would be a good idea to give the linux-fs (namely my
preferred reiser and ext2 :-) some fault-tolerance. I remember there have been
some discussions along this issue some time ago and I guess remembering that it
was decided against because it should be the drivers issue to give the fs a
clean space to live, right? 
Unfortunately todays' reality seems to have gotten a lot worse comparing to one
year ago. I cannot remember a lot of failed drives back then, but today about
20% seemed to be already shipped DOA. Most I came across have only small
problems (few dead sectors), but they seemed to produce quite a lot of trouble 
- at least on my 3ware in non-RAID setup the box partly dies away because
reiser feels quite unhappy about the non-recoverable disk-errors.
I know this question can get religious, but to name my only point: wouldn't it
be a good defensive programming style _not_ to rely on proven-to-be-unreliable
hardware manufacturers. Thing is: you cannot prevent buying bad hardware these
days, because just about every manufacturer already sold bad apples ...

Regards,
Stephan
