Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264380AbTFTSt1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 14:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbTFTSt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 14:49:26 -0400
Received: from [62.75.136.201] ([62.75.136.201]:49288 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S264380AbTFTStZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 14:49:25 -0400
Message-ID: <3EF35A7F.4010001@g-house.de>
Date: Fri, 20 Jun 2003 21:03:27 +0200
From: Christian Kujau <evil@g-house.de>
Reply-To: evil@g-house.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.4b) Gecko/20030507
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: uptime wrong in 2.5.72
References: <Pine.LNX.4.33.0306131117230.12096-100000@gans.physik3.uni-rostock.de> <3EED12F3.5010602@tequila.co.jp>
In-Reply-To: <3EED12F3.5010602@tequila.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,


i have read the thread "uptime wrong in 2.5.70", but it did not occur to 
me or i've just not noticed. now i habve 2.5.72 on an Alpha machine, and 
my uptime is wrong too:

evil@lila:~$ uptime
20:39:43 up 12223 days, 18:39,  2 users,  load average: 1.00, 1.15, 1.13
evil@lila:~$
evil@lila:~$ date
Fri Jun 20 20:39:47 CEST 2003
evil@lila:~$

someone asked for /proc/stat and /proc/uptime, so i'll put it in here too:

evil@lila:~$ cat /proc/uptime
1056134456.56 119.85
evil@lila:~$
evil@lila:~$ cat /proc/stat
cpu  19532572 231368852 6161047 86525 35469
cpu0 19532572 231368852 6161047 86525 35469
intr 268431707 0 18 0 0 0 0 0 0 257197217 0 0 264591 3 0 0 10969878
ctxt 5528866
btime 1055883310
processes 251305
procs_running 2
procs_blocked 0
evil@lila:~$


i'll check if it's reproduceable.

Thanks,
Christian.

