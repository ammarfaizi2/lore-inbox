Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318793AbSIIStp>; Mon, 9 Sep 2002 14:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318833AbSIISto>; Mon, 9 Sep 2002 14:49:44 -0400
Received: from pizda.ninka.net ([216.101.162.242]:27810 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318793AbSIISto>;
	Mon, 9 Sep 2002 14:49:44 -0400
Date: Mon, 09 Sep 2002 11:46:40 -0700 (PDT)
Message-Id: <20020909.114640.76866078.davem@redhat.com>
To: imran.badr@cavium.com
Cc: phillips@arcor.de, akpm@digeo.com, root@chaos.analogic.com,
       linux-kernel@vger.kernel.org
Subject: Re: Calculating kernel logical address ..
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <01a801c25831$913c5fd0$9e10a8c0@IMRANPC>
References: <E17oTBg-0006qd-00@starship>
	<01a801c25831$913c5fd0$9e10a8c0@IMRANPC>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Imran Badr" <imran.badr@cavium.com>
   Date: Mon, 9 Sep 2002 11:49:02 -0700
   
   down(&current->mm->mmap_sem) would help.
   
Yes and get_user_pages() grabs a reference to all the pages
for you.
