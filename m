Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266599AbRGGWAa>; Sat, 7 Jul 2001 18:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266600AbRGGWAK>; Sat, 7 Jul 2001 18:00:10 -0400
Received: from zero.tech9.net ([209.61.188.187]:64004 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S266599AbRGGWAF>;
	Sat, 7 Jul 2001 18:00:05 -0400
Subject: OOM: A Success Report
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Cc: riel@conectiva.com.br
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.10.99 (Preview Release)
Date: 07 Jul 2001 18:00:08 -0400
Message-Id: <994543220.1749.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i thought it would be nice to finally hear something good about the OOM
killer.

i am testing Evolution (Ximian's GNOME emailer/groupware app), and the
latest Evolution cvs-snapshot went crazy when trying to copy a mail
folder.  my load averaged spiked, swap filled, and then i ran out of
memory.

*poof*, Evolution was killed, and everything returned to normal.

kernel showed:
Out of Memory: Killed process 1296 (evolution-mail).
Out of Memory: Killed process 1296 (evolution-mail).
Out of Memory: Killed process 1296 (evolution-mail).
Out of Memory: Killed process 1302 (evolution-mail).
Out of Memory: Killed process 1303 (evolution-mail).
Out of Memory: Killed process 1306 (evolution-mail).
Out of Memory: Killed process 1307 (evolution-mail).

now, i dont know if the load average spiking was evolution's fault, or
not...but everything seemed to work. Good job.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

