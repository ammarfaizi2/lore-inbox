Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315513AbSEQJfd>; Fri, 17 May 2002 05:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315517AbSEQJfc>; Fri, 17 May 2002 05:35:32 -0400
Received: from pizda.ninka.net ([216.101.162.242]:32154 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315513AbSEQJfb>;
	Fri, 17 May 2002 05:35:31 -0400
Date: Fri, 17 May 2002 02:21:48 -0700 (PDT)
Message-Id: <20020517.022148.48851839.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: AUDIT: copy_from_user is a deathtrap.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E178e1l-0007qB-00@wagner.rustcorp.com.au>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@rustcorp.com.au>
   Date: Fri, 17 May 2002 19:27:54 +1000

   There are 415 uses of copy_to/from_user which are wrong, despite an
   audit 12 months ago by the Stanford checker.
   
I would much rather fix these instances than add yet another
interface.
