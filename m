Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315526AbSEQJqW>; Fri, 17 May 2002 05:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315535AbSEQJqV>; Fri, 17 May 2002 05:46:21 -0400
Received: from [202.135.142.196] ([202.135.142.196]:57104 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S315526AbSEQJqV>; Fri, 17 May 2002 05:46:21 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: AUDIT: copy_from_user is a deathtrap. 
In-Reply-To: Your message of "Fri, 17 May 2002 02:21:48 MST."
             <20020517.022148.48851839.davem@redhat.com> 
Date: Fri, 17 May 2002 19:49:40 +1000
Message-Id: <E178eMm-0000NO-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020517.022148.48851839.davem@redhat.com> you write:
>    From: Rusty Russell <rusty@rustcorp.com.au>
>    Date: Fri, 17 May 2002 19:27:54 +1000
> 
>    There are 415 uses of copy_to/from_user which are wrong, despite an
>    audit 12 months ago by the Stanford checker.
>    
> I would much rather fix these instances than add yet another
> interface.

I'll accept that if someone's volunteering to audit the kernel for
them every six months.

Sorry I wasn't clear: I'm saying *replace*, not add,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
