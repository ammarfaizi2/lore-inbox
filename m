Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267013AbSKLV6o>; Tue, 12 Nov 2002 16:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267014AbSKLV6o>; Tue, 12 Nov 2002 16:58:44 -0500
Received: from pizda.ninka.net ([216.101.162.242]:64960 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267013AbSKLV6n>;
	Tue, 12 Nov 2002 16:58:43 -0500
Date: Tue, 12 Nov 2002 14:03:57 -0800 (PST)
Message-Id: <20021112.140357.81690208.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module_name()
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021112174741.6073E2C2B2@lists.samba.org>
References: <20021112174741.6073E2C2B2@lists.samba.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@rustcorp.com.au>
   Date: Wed, 13 Nov 2002 04:32:58 +1100

   I prefer this: it also has the advantage of ensuring the name of
   built-in modules is consistent across the kernel.
   
I'd rather get NULL for built-in, this also eliminates
the issue of having umpteen "[built-in]" string copies in
the kernel since this is expanded by an inline.
