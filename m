Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263312AbSJFE3m>; Sun, 6 Oct 2002 00:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263327AbSJFE3l>; Sun, 6 Oct 2002 00:29:41 -0400
Received: from pizda.ninka.net ([216.101.162.242]:11658 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263312AbSJFE3l>;
	Sun, 6 Oct 2002 00:29:41 -0400
Date: Sat, 05 Oct 2002 21:28:32 -0700 (PDT)
Message-Id: <20021005.212832.102579077.davem@redhat.com>
To: giduru@yahoo.com
Cc: andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: The end of embedded Linux?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021005205238.47023.qmail@web13201.mail.yahoo.com>
References: <Pine.LNX.4.10.10210051252130.21833-100000@master.linux-ide.org>
	<20021005205238.47023.qmail@web13201.mail.yahoo.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Gigi Duru <giduru@yahoo.com>
   Date: Sat, 5 Oct 2002 13:52:38 -0700 (PDT)

   Now thats some advice from a kernel hacker... You
   really don't seem to care too much about embedded, do
   you? 
   
   It's not about what I do not do, it's about what YOU
   do (I'm not talking to you personally, but to the
   hacker community as a whole). The kernel core didn't
   jump to 270KB compressed because I didn't do
   something.

Actually, Andre is quite right.  I can't name too many embedded Linux
folks who haven't customized their kernel in one way or another.  And
in many respects I think that is going to be difficult to avoid
regardless of which free OS you're talking about.

Embedded applications tend to have issues which are entirely specific
to that embedded project.  As such, those are things that do not
belong in a general purpose OS.

The common areas, like smaller hashtables or whatever, sure put a
CONFIG_SMALL_KERNEL option in there and start submitting the
one-liners here and there that do it.
