Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285127AbRLQNRD>; Mon, 17 Dec 2001 08:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285128AbRLQNQy>; Mon, 17 Dec 2001 08:16:54 -0500
Received: from ns.ithnet.com ([217.64.64.10]:37899 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S285127AbRLQNQt>;
	Mon, 17 Dec 2001 08:16:49 -0500
Date: Mon, 17 Dec 2001 14:16:49 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Problem with kernel nfs server in 2.4.17-rc1
Message-Id: <20011217141649.2ee44a10.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I run constantly in a problem with knfsd (or related) that looks like this:
After several hours clients cannot mount via nfs any more, they get:

db:/usr/src/packages/SOURCES # mount /backup
mount: admin:/p2/backup/db failed, reason given by server: Permission denied

On the server I get:

Dec 17 14:09:54 admin rpc.mountd: getfh failed: Operation not permitted 

This issue can always be solved by simply restarting the kernel nfs server.
Does this sound familiar to anybody? I tend to believe this is yet another
issue with knfsd getting into troubles with failed allocs. I can test whatever,
if someone tells me how and what.

Regards,
Stephan
