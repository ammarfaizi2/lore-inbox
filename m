Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270849AbRH1MwL>; Tue, 28 Aug 2001 08:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270855AbRH1MwC>; Tue, 28 Aug 2001 08:52:02 -0400
Received: from habariff.pdc.kth.se ([130.237.221.55]:53120 "EHLO
	habariff.pdc.kth.se") by vger.kernel.org with ESMTP
	id <S270849AbRH1Mv5>; Tue, 28 Aug 2001 08:51:57 -0400
To: linux-kernel@vger.kernel.org
Subject: Size of pointers in sys_call_table?
From: Harald Barth <haba@pdc.kth.se>
X-Mailer: Mew version 1.93 on Emacs 20.4 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010828145304Z.haba@pdc.kth.se>
Date: Tue, 28 Aug 2001 14:53:04 +0200
X-Dispatcher: imput version 980905(IM100)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Most linux kernel ports export the sys_call_table symbol to be used in
modules. I have not succeeded how to automatially figure out the size
of a syscall pointer without inspecting the assembler for the
architecture in question. Examples are mips and sparc64. Have I
missed a syscall_t type available or shouldn't there be one?

Harald.
