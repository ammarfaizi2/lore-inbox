Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130388AbRCLOQw>; Mon, 12 Mar 2001 09:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130381AbRCLOQm>; Mon, 12 Mar 2001 09:16:42 -0500
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:26544 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S130380AbRCLOQa>; Mon, 12 Mar 2001 09:16:30 -0500
Date: Mon, 12 Mar 2001 15:15:48 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Feedback for fastselect and one-copy-pipe
Message-ID: <20010312151548.B878@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manfred,

I'm running your patches [1] with sucess for a while now.

Did you get any feedback about problems regarding these patches?

They seem to work for me, but there seems to be a memleak in
2.4.x (x: 0-2), which I'm chasing down.

The problem is, it only shows up after about 3-4 days of uptime.
So there is no quick test and I'm even not sure about the
kernel version where this exactly occurs, because I run sometimes
2.4.0 for working and sometimes the latest one, to see whether
the problem still persists.

Regards

Ingo Oeser

[1] put on http://www.tu-chemnitz.de/~ioe/fastpipe.patch 
    and http://www.tu-chemnitz.de/~ioe/poll-2.4.0.patch
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
