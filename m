Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277559AbRJOQKD>; Mon, 15 Oct 2001 12:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277652AbRJOQJx>; Mon, 15 Oct 2001 12:09:53 -0400
Received: from service.sh.cvut.cz ([147.32.127.214]:52747 "EHLO
	service.sh.cvut.cz") by vger.kernel.org with ESMTP
	id <S277559AbRJOQJp>; Mon, 15 Oct 2001 12:09:45 -0400
Date: Mon, 15 Oct 2001 18:10:12 +0200 (CEST)
From: Martin Kacer <M.Kacer@sh.cvut.cz>
X-X-Sender: <donald@duck.sh.cvut.cz>
To: <linux-kernel@vger.kernel.org>
Subject: Up-to-date load information
Message-ID: <Pine.LNX.4.31.0110151809160.29687-100000@duck.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there!

   Is there any chance to determine the number of running/ready processes
(aka "system load") updated more often than usual? I need much more
up-to-date information than one-minute avarage which is provided by
`uptime' and /proc/loadavg. Probably, one-second or (at most) five-second
average would be ideal.

   Is there any kernel module/option providing such (or similar)
functionality? Do you think it could be useful for anyone else?
If I need to write my own module to provide such data (I really NEED them
in my case), what is the best way to do so? Kernel thread polling the
value of nr_running periodically? Checking this value with each context
switch?

   Another solution is to check nr_running from /proc/loadavg in the user
mode. However, I am afraid this could be inaccurate (and maybe slow). Also
using the number of running processes directly (not an average) can be
misguided.

   Any suggestions? Please, CC a reply to me, since I am temporarily
signed off this list. Thanks.

   Martin.

