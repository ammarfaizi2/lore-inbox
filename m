Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129381AbRDPKbi>; Mon, 16 Apr 2001 06:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130317AbRDPKb2>; Mon, 16 Apr 2001 06:31:28 -0400
Received: from mail.relex.ru ([213.24.247.153]:4875 "EHLO mail.relex.ru")
	by vger.kernel.org with ESMTP id <S129381AbRDPKbP>;
	Mon, 16 Apr 2001 06:31:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Yaroslav Rastrigin <yarick@relex.ru>
Organization: RELEX Inc.
To: linux-kernel@vger.kernel.org
Subject: Possibly stupid question
Date: Mon, 16 Apr 2001 14:28:46 +0400
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01041614284600.17911@yarick>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody !

I'm begging your pardon for possibly stupid question,
but digging through headers/sources of kernel gives me next to nothing.
The question is:
can I use IPC (specifically, msgsnd/msgrcv) inside of loadable module ?
<linux/msg.h> defines 
sys_msgsnd and sys_msgrcv, but insmod'ing my module
says this symbols are undefined, ksyms -a | grep sys
confirms total internality of this functions (in other words, this symbols 
aren't exported :)
Can usage of sys_call_table[__NR_sys_ipc] help me, or this is totally wrong 
approach ? 
These mechanisms (IPC message queues) are fitting really nicely into my task, 
and I don't want to reimplement the wheel.

Please, tell me, where to look.
With all the best, yarick at relex dot ru
