Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261910AbSJECYX>; Fri, 4 Oct 2002 22:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261913AbSJECYX>; Fri, 4 Oct 2002 22:24:23 -0400
Received: from pizda.ninka.net ([216.101.162.242]:60387 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261910AbSJECYX>;
	Fri, 4 Oct 2002 22:24:23 -0400
Date: Fri, 04 Oct 2002 19:22:29 -0700 (PDT)
Message-Id: <20021004.192229.100409181.davem@redhat.com>
To: torvalds@transmeta.com
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: oops in bk pull (oct 03)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0210041913340.1253-100000@home.transmeta.com>
References: <20021004.190053.69975722.davem@redhat.com>
	<Pine.LNX.4.44.0210041913340.1253-100000@home.transmeta.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Fri, 4 Oct 2002 19:22:50 -0700 (PDT)
   
   Oh, ~0 is better for a lot of reasons:

So the bug really is making the host bridge mapping alias
potentially with normal memory mappings.

Ok I buy that.
