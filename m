Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262250AbSJQWiC>; Thu, 17 Oct 2002 18:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262253AbSJQWiC>; Thu, 17 Oct 2002 18:38:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:192 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262250AbSJQWiB>;
	Thu, 17 Oct 2002 18:38:01 -0400
Date: Thu, 17 Oct 2002 15:36:27 -0700 (PDT)
Message-Id: <20021017.153627.132905359.davem@redhat.com>
To: daw@mozart.cs.berkeley.edu
Cc: linux-kernel@vger.kernel.org
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] remove sys_security
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <aonbj9$pun$1@abraham.cs.berkeley.edu>
References: <20021017185352.GA32537@kroah.com>
	<20021017.131830.27803403.davem@redhat.com>
	<aonbj9$pun$1@abraham.cs.berkeley.edu>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: daw@mozart.cs.berkeley.edu (David Wagner)
   Date: 17 Oct 2002 21:54:49 GMT
   
   For example, the LSM folks have several performance
   measurements that show that the performance overhead of LSM is
   basically negligible, so that's one way that users won't notice it
   is there.

How about size measurements?  As in, the kernel is at a minimum
several Kb larger than if CONFIG_SECURITY=n

And about prospective usage of LSM, it can be judged even though it
isn't in the tree yet.  That's how we decide what to put into the
kernel to begin with.

Look at your average user, he doesn't really care about LSM.  He wants
to be able to play his music, play quake3, surf the web, write emails
and compose documents.  If he's a developer he also wants to compile
programs and source management tools.  If he's an artist or
professional photographer, he wants something like the GIMP.

Sure, it might become popular on multi-user machines to use
some sort of LSM module for this purpose or that.

But as far as raw seats are concerned, the majority will not use
LSM.  They simply have no need for it on their workstation.
