Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267162AbSKMKvf>; Wed, 13 Nov 2002 05:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267165AbSKMKvf>; Wed, 13 Nov 2002 05:51:35 -0500
Received: from pizda.ninka.net ([216.101.162.242]:1477 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267162AbSKMKve>;
	Wed, 13 Nov 2002 05:51:34 -0500
Date: Wed, 13 Nov 2002 02:56:45 -0800 (PST)
Message-Id: <20021113.025645.60825209.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module_name() 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021113100541.3E2652C085@lists.samba.org>
References: <20021112.140357.81690208.davem@redhat.com>
	<20021113100541.3E2652C085@lists.samba.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@rustcorp.com.au>
   Date: Wed, 13 Nov 2002 21:04:10 +1100
   
   > this also eliminates the issue of having umpteen "[built-in]" string
   > copies in the kernel since this is expanded by an inline.
   
   Ick, yes.   Turned into macros, and changed to "kernel" since
   exec_domain.c already uses that.
   
   Thoughts?

Ok, since when mod is NULL crypto.h won't even invoke module_name()
anyways :-)
