Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271106AbRH1O3k>; Tue, 28 Aug 2001 10:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271082AbRH1O3a>; Tue, 28 Aug 2001 10:29:30 -0400
Received: from habariff.pdc.kth.se ([130.237.221.55]:57728 "EHLO
	habariff.pdc.kth.se") by vger.kernel.org with ESMTP
	id <S271106AbRH1O3S>; Tue, 28 Aug 2001 10:29:18 -0400
To: bgerst@didntduck.org
Cc: haba@pdc.kth.se, linux-kernel@vger.kernel.org
Subject: Re: Size of pointers in sys_call_table?
From: Harald Barth <haba@pdc.kth.se>
In-Reply-To: Your message of "Tue, 28 Aug 2001 09:26:24 -0400"
	<3B8B9C00.4842710D@didntduck.org>
In-Reply-To: <3B8B9C00.4842710D@didntduck.org>
X-Mailer: Mew version 1.93 on Emacs 20.4 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010828163020P.haba@pdc.kth.se>
Date: Tue, 28 Aug 2001 16:30:20 +0200
X-Dispatcher: imput version 980905(IM100)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The layout of the sys_call_table is totally architecture dependant.  The
> question to ask here is why do you need to use it?  Modifying it to hook
> into syscalls is frowned upon.

I want to set the "frowning upon" aside just for the moment and point
to the fact that the symbol actually is exported and in consequence
should be described by some data type. The data type may be "totally
architecture dependant".

I can join the frowning upon if we extend it to be about the export
of the sys_call_table in the first place, but there are no other means
to populate a syscall from a module, or have I missed something?

The different AFS implementations have used this for years.

Harald.
