Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRA3Qwe>; Tue, 30 Jan 2001 11:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129632AbRA3QwZ>; Tue, 30 Jan 2001 11:52:25 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:59385 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S129051AbRA3QwE>; Tue, 30 Jan 2001 11:52:04 -0500
Date: Tue, 30 Jan 2001 10:52:02 -0600
From: Timur Tabi <ttabi@interactivesi.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <7085.980853087@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0101291018080.5353-100000@ns-01.hislinuxbox.com> 
	<Pine.LNX.4.21.0101291018080.5353-100000@ns-01.hislinuxbox.com>
Subject: Re: [ANNOUNCE] Kernel Janitor's TODO list
X-Mailer: The Polarbar Mailer; version=1.19a; build=73
Message-ID: <Mdiqd.A.qe.yEvd6@dinero.interactivesi.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from David Woodhouse <dwmw2@infradead.org> on Tue, 30 Jan
2001 11:11:27 +0000


> Note that this is _precisely_ the reason I'm advocating the removal of 
> sleep_on(). When I was young and stupid (ok, "younger and stupider") I used 
> sleep_on() in my code. I pondered briefly the fact that I really couldn't 
> convince myself that it was safe, but because it was used in so many other 
> places, I decided I had to be missing something, and used it anyway.
> 
> I was wrong. I was copying broken code. And now I want to remove all those 
> bad examples - for the benefit of those who are looking at them now and are 
> tempted to copy them.

What is wrong with sleep_on()?


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
