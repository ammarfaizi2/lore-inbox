Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261630AbSJCOyK>; Thu, 3 Oct 2002 10:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263266AbSJCOyJ>; Thu, 3 Oct 2002 10:54:09 -0400
Received: from pizda.ninka.net ([216.101.162.242]:65490 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261630AbSJCOyI>;
	Thu, 3 Oct 2002 10:54:08 -0400
Date: Thu, 03 Oct 2002 07:52:24 -0700 (PDT)
Message-Id: <20021003.075224.27940200.davem@redhat.com>
To: willy@debian.org
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Start of cleaning up socket ioctls
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021003155241.G28586@parcelfarce.linux.theplanet.co.uk>
References: <20021003155241.G28586@parcelfarce.linux.theplanet.co.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Matthew Wilcox <willy@debian.org>
   Date: Thu, 3 Oct 2002 15:52:41 +0100

   All the ioctls are passed to the socket's ioctl methods, even when they're
   utterly generic.  Here's a patch which starts to move the really generic
   ones up to the top level.  As you can see, this eliminates a huge amount
   of code duplication.

Looks fine, I'll apply this and push to Linus.
