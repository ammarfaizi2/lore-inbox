Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbTJSRuv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 13:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbTJSRuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 13:50:51 -0400
Received: from mailhost.cs.auc.dk ([130.225.194.6]:38853 "EHLO
	mailhost.cs.auc.dk") by vger.kernel.org with ESMTP id S262016AbTJSRuu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 13:50:50 -0400
Subject: Porting code from 2.4.x to 2.6.x
From: Emmanuel Fleury <fleury@cs.auc.dk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Aalborg University -- Computer Science Dept.
Message-Id: <1066585811.2738.17.camel@rade7.s.cs.auc.dk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 19 Oct 2003 19:50:11 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm trying to port some code from 2.4.x to 2.6.x.
I got a very strange error, that I would like to submit here (it might
help, we never know).

I am working with a clean 2.6.0-test7 (the test8 is scaring me a little
bit with all these reports I saw on the list :).

 irq.h
=======

/lib/modules/2.6.0-stable/build/include/asm/irq.h:16:25: irq_vectors.h:
No such file or directory

So basically, the "irq_vectors.h" file has disappeared...

But, we still can find it in:
./include/asm-um/irq_vectors.h
./include/asm-i386/mach-default/irq_vectors.h
./include/asm-i386/mach-visws/irq_vectors.h
./include/asm-i386/mach-pc9800/irq_vectors.h
./include/asm-i386/mach-voyager/irq_vectors.h


Any ideas ????

Regards
-- 
Emmanuel

There are two major products that come out of Berkeley: LSD and UNIX.
We don't believe this to be a coincidence.
  -- Jeremy S. Anderson

