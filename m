Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261733AbSLHW1W>; Sun, 8 Dec 2002 17:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261742AbSLHW1W>; Sun, 8 Dec 2002 17:27:22 -0500
Received: from pizda.ninka.net ([216.101.162.242]:13193 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261733AbSLHW1V>;
	Sun, 8 Dec 2002 17:27:21 -0500
Date: Sun, 08 Dec 2002 14:31:26 -0800 (PST)
Message-Id: <20021208.143126.19133692.davem@redhat.com>
To: jmorris@intercode.com.au
Cc: adam@yggdrasil.com, linux-kernel@vger.kernel.org
Subject: Re: Patch(2.5.50): Simplify crypto memory allocation
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Mutt.LNX.4.44.0212082149400.23807-100000@blackbird.intercode.com.au>
References: <20021208012727.A24577@baldur.yggdrasil.com>
	<Mutt.LNX.4.44.0212082149400.23807-100000@blackbird.intercode.com.au>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: James Morris <jmorris@intercode.com.au>
   Date: Sun, 8 Dec 2002 21:55:15 +1100 (EST)

   On Sun, 8 Dec 2002, Adam J. Richter wrote:
   
   > 	Anyhow, if this patch turns out to work and looks OK, then
   > please integrate, queue it for Linus, etc., or let me know if you
   > would prefer that you or I follow some other course of action.
   
   Looks good and tests ok.  Thanks.  
   
I'll apply this, thanks Adam.

   (The work_block field and associated management code should have
   disappeared long ago, not sure why it was still there).

We just didn't do this part when the conversion was made :-)
