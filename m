Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271384AbTHHPOa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 11:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271399AbTHHPOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 11:14:30 -0400
Received: from routeree.utt.ro ([193.226.8.102]:44002 "EHLO klesk.etc.utt.ro")
	by vger.kernel.org with ESMTP id S271384AbTHHPO1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 11:14:27 -0400
Message-ID: <28816.194.138.39.55.1060356015.squirrel@webmail.etc.utt.ro>
Date: Fri, 8 Aug 2003 18:20:15 +0300 (EEST)
Subject: Re: 2.6: More about interactivity
From: "Szonyi Calin" <sony@etc.utt.ro>
To: <felipe_alfaro@linuxmail.org>
In-Reply-To: <1060280139.1406.17.camel@teapot.felipe-alfaro.com>
References: <1060280139.1406.17.camel@teapot.felipe-alfaro.com>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana said:
>
> With X reniced at +0, the system feels not as smooth as 2.6.0-test2-mm2,
> but at least there are no sound skips. However, to gain on smoothness, I
> have chosen to renice X to -20. Renicing X to -20 makes Juk skip like
> crazy simply by dragging a window over the screen. Also, with X at -20,
> opening a long Bookmarks Konqueror menu also causes sound skips (even
> with XMMS). By now, I'm sticking at +0, but I really miss those times
> when I was running O10int and the desktop was as smooth as silk.
>

Some comments:
Renicing X at -20 is silly. It is normal that xmms skips when
X is reniced because X gets the cpu time not xmms.
Also a normal user doesn't have access to nice values below
zero, so the scheduler should work for normal systems not
for those in which process foo is reniced at -bar priority.

Calin

-- 
# fortune
fortune: write error on /dev/null --- please empty the bit bucket


-----------------------------------------
This email was sent using SquirrelMail.
   "Webmail for nuts!"
http://squirrelmail.org/


