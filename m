Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269373AbTCDLQe>; Tue, 4 Mar 2003 06:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269378AbTCDLQe>; Tue, 4 Mar 2003 06:16:34 -0500
Received: from pizda.ninka.net ([216.101.162.242]:59824 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S269373AbTCDLQd>;
	Tue, 4 Mar 2003 06:16:33 -0500
Date: Tue, 04 Mar 2003 03:09:10 -0800 (PST)
Message-Id: <20030304.030910.63662193.davem@redhat.com>
To: pavel@ucw.cz
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: sys32_ioctl -> compat_ioctl -- sparc64
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030303232513.GA24047@elf.ucw.cz>
References: <20030303232513.GA24047@elf.ucw.cz>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pavel Machek <pavel@ucw.cz>
   Date: Tue, 4 Mar 2003 00:25:13 +0100

   This is sparc64-specific part. It removes hack where pointers to
   functions were stored in 32bits, making ioctl table bigger, but I
   guess that should not be a big problem (and can be fixed later).
   
This is OK temporarily, but should be fixed eventually.
