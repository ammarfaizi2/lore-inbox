Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287344AbSBKGyi>; Mon, 11 Feb 2002 01:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287386AbSBKGyS>; Mon, 11 Feb 2002 01:54:18 -0500
Received: from pizda.ninka.net ([216.101.162.242]:30603 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S287344AbSBKGyR>;
	Mon, 11 Feb 2002 01:54:17 -0500
Date: Sun, 10 Feb 2002 22:52:23 -0800 (PST)
Message-Id: <20020210.225223.15255103.davem@redhat.com>
To: akpm@zip.com.au
Cc: weber@nyc.rr.com, jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.4 Compile Error
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C676959.9F401A7B@zip.com.au>
In-Reply-To: <3C6764E6.DB1E8F8D@zip.com.au>
	<20020210.223329.35676006.davem@redhat.com>
	<3C676959.9F401A7B@zip.com.au>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@zip.com.au>
   Date: Sun, 10 Feb 2002 22:48:57 -0800

   "David S. Miller" wrote:
   > Not sufficient, you have to also add a dummy "struct task_struct;"
   > declaration before the thread_saved_pc extern.
   
   It's already there, line 425?

Yep, my error.
