Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130374AbQLETa7>; Tue, 5 Dec 2000 14:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130379AbQLETau>; Tue, 5 Dec 2000 14:30:50 -0500
Received: from [194.213.32.137] ([194.213.32.137]:1028 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S130374AbQLETad>;
	Tue, 5 Dec 2000 14:30:33 -0500
Message-ID: <20001205004049.A1316@bug.ucw.cz>
Date: Tue, 5 Dec 2000 00:40:49 +0100
From: Pavel Machek <pavel@suse.cz>
To: Kevin Buhr <buhr@stat.wisc.edu>, trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
Subject: Re: negative NFS cookies: bad C library or bad kernel?
In-Reply-To: <vbaaeae2joz.fsf@mozart.stat.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <vbaaeae2joz.fsf@mozart.stat.wisc.edu>; from Kevin Buhr on Sat, Dec 02, 2000 at 10:49:16PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Fiddling with the Crytographic File System the other day, I managed to
> tickle a mysterious bug.  When some directories grew large enough,
> suddenly a chunk of files would half "disappear".  "find" would list
> them fine, but "ls" and "echo *" wouldn't.
> 
> After a bit of troubleshooting, I discovered that the CFS daemon
> (which presents itself to the system as an NFS daemon) was using

Do you run CFS daemon and client on same machine? Where is
documentation/download of CFS?

								Pavel 
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
