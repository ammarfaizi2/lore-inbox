Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130584AbQKNEiM>; Mon, 13 Nov 2000 23:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130604AbQKNEhw>; Mon, 13 Nov 2000 23:37:52 -0500
Received: from CPE-61-9-148-32.vic.bigpond.net.au ([61.9.148.32]:14604 "HELO
	halfway.linuxcare.com.au") by vger.kernel.org with SMTP
	id <S130584AbQKNEhn>; Mon, 13 Nov 2000 23:37:43 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 Status/TODO page (test11-pre3) 
In-Reply-To: Your message of "Sun, 12 Nov 2000 22:09:39 CDT."
             <3A0F5B73.E613050B@mandrakesoft.com> 
Date: Tue, 14 Nov 2000 15:07:38 +1100
Message-Id: <20001114040738.D28BE81F1@halfway.linuxcare.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3A0F5B73.E613050B@mandrakesoft.com> you write:
> > 12. Probably Post 2.4
> 
> >      * module remove race bugs (ipchains modules -- Rusty; won't fix for
> >        2.4)
> 
> Is this an ipchains bug, or a more general module subsystem bug?

There's a fundamental problem with any module which reduces counts in
interrupts.  Viro's `solution' doesn't apply here; there is a real
solution but I Believed In The Code Freeze.

Rusty.
--
Hacking time.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
