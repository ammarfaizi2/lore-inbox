Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292895AbSCDUoK>; Mon, 4 Mar 2002 15:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292891AbSCDUn7>; Mon, 4 Mar 2002 15:43:59 -0500
Received: from mnh-1-15.mv.com ([207.22.10.47]:39175 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S292895AbSCDUnw>;
	Mon, 4 Mar 2002 15:43:52 -0500
Message-Id: <200203042046.PAA04125@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages 
In-Reply-To: Your message of "Mon, 04 Mar 2002 18:49:47 GMT."
             <E16hxWu-0000Bc-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 04 Mar 2002 15:46:07 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan@lxorguk.ukuu.org.uk said:
> Ok got you - 

Good, if that's not being sarcastic...

> so its merely grossly ineffecient and downright rude to
> other users of the system ? 

OK, when something calls alloc_pages and gets back some pages, it's almost
always going to modify them immediately, right?

If this is true, then what I'm proposing would force the host to find backing
memory for those pages a tiny bit earlier than it would have had to otherwise.

This is the only possibility for inefficiency and rudeness that I can see.
If I'm totally missing what you are referring to, please be a little bit more
specific.

				Jeff

