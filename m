Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287337AbSBKHNN>; Mon, 11 Feb 2002 02:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287436AbSBKHNE>; Mon, 11 Feb 2002 02:13:04 -0500
Received: from zeus.kernel.org ([204.152.189.113]:51867 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S287337AbSBKHMv>;
	Mon, 11 Feb 2002 02:12:51 -0500
Date: Sun, 10 Feb 2002 22:33:29 -0800 (PST)
Message-Id: <20020210.223329.35676006.davem@redhat.com>
To: akpm@zip.com.au
Cc: weber@nyc.rr.com, jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.4 Compile Error
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C6764E6.DB1E8F8D@zip.com.au>
In-Reply-To: <3C6750CD.46575DAA@mandrakesoft.com>
	<3C675E6B.4010605@nyc.rr.com>
	<3C6764E6.DB1E8F8D@zip.com.au>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@zip.com.au>
   Date: Sun, 10 Feb 2002 22:29:58 -0800

   John Weber wrote:
   > I don't know what the problem is, but un-inlining this function isn't
   > correcting it.
   
   Try this:
   
Not sufficient, you have to also add a dummy "struct task_struct;"
declaration before the thread_saved_pc extern.
