Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314358AbSE0GOG>; Mon, 27 May 2002 02:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314379AbSE0GOF>; Mon, 27 May 2002 02:14:05 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:56014 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S314358AbSE0GOE>; Mon, 27 May 2002 02:14:04 -0400
Date: Mon, 27 May 2002 15:58:04 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Pavel Machek <pavel@ucw.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: swsusp for 2.5.18: kill broken Magic-D support
Message-Id: <20020527155804.229232a1.rusty@rustcorp.com.au>
In-Reply-To: <20020526185724.GA16004@elf.ucw.cz>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 May 2002 20:57:24 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> It is probably good idea to create rule that suspend may only be done
> from process context... And it simplifies code a lot. Here's the
> patch.

You could have it call "schedule_task" of course...

Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
