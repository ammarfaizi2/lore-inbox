Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132253AbQLJVwz>; Sun, 10 Dec 2000 16:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132642AbQLJVwo>; Sun, 10 Dec 2000 16:52:44 -0500
Received: from [194.213.32.137] ([194.213.32.137]:516 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S132253AbQLJVw2>;
	Sun, 10 Dec 2000 16:52:28 -0500
Message-ID: <20001210124553.A154@bug.ucw.cz>
Date: Sun, 10 Dec 2000 12:45:53 +0100
From: Pavel Machek <pavel@suse.cz>
To: Zhiruo Cao <zhiruo@cc.gatech.edu>, linux-kernel@vger.kernel.org
Subject: Re: who is writing to disk
In-Reply-To: <Pine.GSU.4.21.0012072119450.9251-100000@lennon.cc.gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.GSU.4.21.0012072119450.9251-100000@lennon.cc.gatech.edu>; from Zhiruo Cao on Thu, Dec 07, 2000 at 09:25:03PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I found a process constantly writing to disk when I run gnome as desktop 
> and while the whole system is idle.  I don't find anything in the log
> file, and I don't see anything updated in my home dir or in /tmp.  Does it
> sound like bdflush is writing?  But I don't hear the disk access when I
> am not running gnome.  
> 
> My question then is, is there a (monitoring) tool that can tell me who is
> writing to disk?  Or how I configure the kernel to know that?

Access time updates? Try mounting with noatime.
								Pavel

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
