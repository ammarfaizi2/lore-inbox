Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261888AbSI3BUB>; Sun, 29 Sep 2002 21:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261892AbSI3BUB>; Sun, 29 Sep 2002 21:20:01 -0400
Received: from pizda.ninka.net ([216.101.162.242]:48299 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261888AbSI3BUA>;
	Sun, 29 Sep 2002 21:20:00 -0400
Date: Sun, 29 Sep 2002 18:18:40 -0700 (PDT)
Message-Id: <20020929.181840.15673483.davem@redhat.com>
To: omit@rice.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-kernel@vger.kernel.org
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <00d601c2681e$a60c3280$7f71a018@OMIT>
References: <00d601c2681e$a60c3280$7f71a018@OMIT>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "omit_ECE" <omit@rice.edu>
   Date: Sun, 29 Sep 2002 20:13:56 -0500
   
   Aren't "printf" and "fprintf"  standard outputs?

There is not standard output in the kernel, and you can't assume
libc facilities are all available.

Use "printk" available from linux/kernel.h instead.
