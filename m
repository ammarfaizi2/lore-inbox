Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136517AbRASBXX>; Thu, 18 Jan 2001 20:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136531AbRASBXM>; Thu, 18 Jan 2001 20:23:12 -0500
Received: from ns1.SuSE.com ([202.58.118.2]:21001 "HELO ns1.suse.com")
	by vger.kernel.org with SMTP id <S136517AbRASBXF>;
	Thu, 18 Jan 2001 20:23:05 -0500
Date: Thu, 18 Jan 2001 17:23:11 -0800 (PST)
From: James Simmons <jsimmons@suse.com>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        FrameBuffer List <linux-fbdev@vuser.vu.union.edu>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: console spin_lock
In-Reply-To: <3A66E4D3.B2BEFCBB@uow.edu.au>
Message-ID: <Pine.LNX.4.21.0101181719070.264-100000@euclid.oak.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This statement of mine was grade-A bollocks.  printk cannot of
> course call down().  It needs to use __down_trylock and buffer
> it up if it fails. (faster, too!)

Okay. I'm going to start working on this tomorrow. 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
