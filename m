Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290754AbSBLDo2>; Mon, 11 Feb 2002 22:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290753AbSBLDoR>; Mon, 11 Feb 2002 22:44:17 -0500
Received: from pizda.ninka.net ([216.101.162.242]:63367 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S290752AbSBLDoI>;
	Mon, 11 Feb 2002 22:44:08 -0500
Date: Mon, 11 Feb 2002 19:42:22 -0800 (PST)
Message-Id: <20020211.194222.34761071.davem@redhat.com>
To: davidm@hpl.hp.com
Cc: anton@samba.org, linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: thread_info implementation
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15464.36074.246502.582895@napali.hpl.hp.com>
In-Reply-To: <15464.35214.669412.477377@napali.hpl.hp.com>
	<20020211.192334.123921982.davem@redhat.com>
	<15464.36074.246502.582895@napali.hpl.hp.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@hpl.hp.com>
   Date: Mon, 11 Feb 2002 19:32:58 -0800
   
     DaveM> The compiler will schedule the latency out of existence.
   
   The kernel has many paths that have sequential dependencies.  If there
   is no other work to do, the compiler won't help you.

You mean the company with the most register starved modern processor
can't make a load go fast? :-)  I totally beg to differ, and I think
people like Linus will too.
