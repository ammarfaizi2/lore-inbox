Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268714AbRIEJPQ>; Wed, 5 Sep 2001 05:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268916AbRIEJPG>; Wed, 5 Sep 2001 05:15:06 -0400
Received: from mercury.rus.uni-stuttgart.de ([129.69.1.226]:60678 "EHLO
	mercury.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S268714AbRIEJO5>; Wed, 5 Sep 2001 05:14:57 -0400
To: linux-kernel@vger.kernel.org
Subject: getpeereid() for Linux
From: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Date: 05 Sep 2001 11:14:41 +0200
Message-ID: <tgsne23sou.fsf@mercury.rus.uni-stuttgart.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Would anyone like to give me a helping hand in implementing the
getpeereid() syscall for Linux?  See the following page for the
documentation of the OpenBSD implementation:

http://www.openbsd.org/cgi-bin/man.cgi?query=getpeereid&sektion=2&apropos=0&manpath=OpenBSD+Current

I think I could work out the kernel data structures to gather the
relevant data from, however, I won't get all the locking stuff right.

OTOH, is there any chance that the addition of such a syscall would be
accepted?

Thanks to /proc, it is possible to implement the user ID part of the
syscall in userland, at least for TCP sockets, but this isn't enough.
(I've got a such an implementation which seems to work quite well,
just in case you are interested.)

-- 
Florian Weimer 	                  Florian.Weimer@RUS.Uni-Stuttgart.DE
University of Stuttgart           http://cert.uni-stuttgart.de/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
