Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbTEGDu3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 23:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbTEGDu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 23:50:29 -0400
Received: from pizda.ninka.net ([216.101.162.242]:45036 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262805AbTEGDu2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 23:50:28 -0400
Date: Tue, 06 May 2003 19:55:11 -0700 (PDT)
Message-Id: <20030506.195511.74729679.davem@redhat.com>
To: george@mvista.com
Cc: akpm@zip.com.au, kbuild-devel@lists.sourceforge.net, mec@shout.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-generic magic
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3EB817C9.8020603@mvista.com>
References: <3EB75924.1080304@mvista.com>
	<1052205991.983.13.camel@rth.ninka.net>
	<3EB817C9.8020603@mvista.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: george anzinger <george@mvista.com>
   Date: Tue, 06 May 2003 13:15:05 -0700

   David S. Miller wrote:
   > This is not at all how this stuff is supposed to work.
   
   Um, where might one learn how it is _supposed_ to work?

By looking at existing uses.

Some files provide partial APIs, other files are "configured'
by the asm-ARCH/foo.h header before being included.
