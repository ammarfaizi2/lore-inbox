Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278399AbRJMUbx>; Sat, 13 Oct 2001 16:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278400AbRJMUbn>; Sat, 13 Oct 2001 16:31:43 -0400
Received: from zok.sgi.com ([204.94.215.101]:5613 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S278399AbRJMUb0>;
	Sat, 13 Oct 2001 16:31:26 -0400
Message-Id: <200110132030.f9DKU6D02263@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Pavel Machek <pavel@suse.cz>
cc: David Woodhouse <dwmw2@infradead.org>, adam.keys@HOTARD.engr.smu.edu,
        linux-kernel@vger.kernel.org
Subject: Re: journaling and devel [was Re: Development Setups] 
In-Reply-To: Message from Pavel Machek <pavel@suse.cz> 
   of "Sat, 06 Oct 2001 00:27:41 -0000." <20011006002741.A35@toy.ucw.cz> 
Date: Sat, 13 Oct 2001 15:30:06 -0500
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> I disagree.. With journal filesystem, when something is silently corrupting
> your disk, you'll never know. With ext2, you sometimes sync & reset to make
> sure your disks are still healthy. I would not recommend journaling on 
> experimental boxes.
> 								Pavel

On the otherhand I have found the main problem with using XFS on development
platforms is that you do not test the kernel shutdown code very much.
It is much faster to just reset the box than to do a shutdown, and it
does not make a difference when you bring it back up.

Steve


