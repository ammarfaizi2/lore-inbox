Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129101AbRA3LQX>; Tue, 30 Jan 2001 06:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129759AbRA3LQN>; Tue, 30 Jan 2001 06:16:13 -0500
Received: from [172.16.18.67] ([172.16.18.67]:29828 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S129704AbRA3LQI>; Tue, 30 Jan 2001 06:16:08 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.21.0101291018080.5353-100000@ns-01.hislinuxbox.com> 
In-Reply-To: <Pine.LNX.4.21.0101291018080.5353-100000@ns-01.hislinuxbox.com> 
To: "David D.W. Downey" <pgpkeys@hislinuxbox.com>
Cc: John Levon <moz@compsoc.man.ac.uk>, Timur Tabi <ttabi@interactivesi.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Kernel Janitor's TODO list 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 30 Jan 2001 11:11:27 +0000
Message-ID: <7085.980853087@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


pgpkeys@hislinuxbox.com said:
>  Remember, most of you guys have been coding for years, or working on
> the kernel for years. Some of us don't have that level of expertise,
> are trying to get it, and feel like we're being told that information
> is a private domain we aren't allowed in to.

Note that this is _precisely_ the reason I'm advocating the removal of 
sleep_on(). When I was young and stupid (ok, "younger and stupider") I used 
sleep_on() in my code. I pondered briefly the fact that I really couldn't 
convince myself that it was safe, but because it was used in so many other 
places, I decided I had to be missing something, and used it anyway.

I was wrong. I was copying broken code. And now I want to remove all those 
bad examples - for the benefit of those who are looking at them now and are 
tempted to copy them.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
