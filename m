Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272080AbRJHJto>; Mon, 8 Oct 2001 05:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276831AbRJHJte>; Mon, 8 Oct 2001 05:49:34 -0400
Received: from pizda.ninka.net ([216.101.162.242]:7808 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S272080AbRJHJtV>;
	Mon, 8 Oct 2001 05:49:21 -0400
Date: Mon, 08 Oct 2001 02:49:46 -0700 (PDT)
Message-Id: <20011008.024946.74749362.davem@redhat.com>
To: panto@intracom.gr
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Standard way of generating assembler offsets
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3BC1735F.41CBF5C1@intracom.gr>
In-Reply-To: <28136.1002196028@ocs3.intra.ocs.com.au>
	<3BC1735F.41CBF5C1@intracom.gr>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pantelis Antoniou <panto@intracom.gr>
   Date: Mon, 08 Oct 2001 12:35:27 +0300
   
   If anyone is interested I have already made a perl
   script that produces assembler offsets from structure
   members.
   
   It doesn't need to run native since it reads the
   header files, extract the structures and by using
   objdump calculates the offsets automatically.

BTW, I assume you have already taken a look at how we
do this on Sparc64.  See arch/sparc64/kernel/check_asm.sh
and the "check_asm" target in arch/sparc64/kernel/Makefile

It also works in all cross-compilation etc. environments.
And I bet it would work on every platform with very minimal
changes, if any.

Franks a lot,
David S. Miller
davem@redhat.com
