Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315481AbSEMCVd>; Sun, 12 May 2002 22:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315482AbSEMCVc>; Sun, 12 May 2002 22:21:32 -0400
Received: from pizda.ninka.net ([216.101.162.242]:21973 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315481AbSEMCV3>;
	Sun, 12 May 2002 22:21:29 -0400
Date: Sun, 12 May 2002 19:08:57 -0700 (PDT)
Message-Id: <20020512.190857.07007452.davem@redhat.com>
To: torvalds@transmeta.com
Cc: wrose@loislaw.com, linux-kernel@vger.kernel.org
Subject: Re: Segfault hidden in list.h
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0205121805220.15392-100000@home.transmeta.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Sun, 12 May 2002 18:08:28 -0700 (PDT)

   And I'm sure as hell not going to put any lockless stuff in functions
   meant for "normal human consumption". If we create list macros like that,
   they had better be called "lockless_list_add_be_damn_careful_about_it()"
   rather than "list_add()".
   
That was what I was suggesting.  I didn't intend for the memory
barriers to go into the existing list macros.
