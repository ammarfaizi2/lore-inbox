Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289711AbSAOWtH>; Tue, 15 Jan 2002 17:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289712AbSAOWss>; Tue, 15 Jan 2002 17:48:48 -0500
Received: from port-213-20-228-123.reverse.qdsl-home.de ([213.20.228.123]:23050
	"EHLO drocklinux.dyndns.org") by vger.kernel.org with ESMTP
	id <S289711AbSAOWsk> convert rfc822-to-8bit; Tue, 15 Jan 2002 17:48:40 -0500
Date: Tue, 15 Jan 2002 23:48:23 +0100 (CET)
Message-Id: <20020115.234823.884032698.rene.rebe@gmx.net>
To: mingo@elte.hu
Cc: davidel@xmailserver.org, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) scheduler, -I1
From: Rene Rebe <rene.rebe@gmx.net>
In-Reply-To: <Pine.LNX.4.33.0201152022590.14517-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.40.0201150915590.1460-100000@blue1.dev.mcafeelabs.com>
	<Pine.LNX.4.33.0201152022590.14517-100000@localhost.localdomain>
X-Mailer: Mew version 2.1 on XEmacs 21.4.6 (Common Lisp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I just tried the sched-O1-2.4.17-I0.patch and interactive performance
is unbelieveable bad!

- When I start compiling (not niced) s.th. the X server never starts!
I have to kill it remotely and do a chvt ...

- So I stopped(!!) the compilation to start XFree. During a CPU
intensive application I can drag the windows with < 1 frame per
second! I never dragged a window arround in such a low speed! (again
nothing reniced - just one gcc running ...)

From: Ingo Molnar <mingo@elte.hu>
Subject: [patch] O(1) scheduler, -I1
Date: Tue, 15 Jan 2002 21:35:10 +0100 (CET)

> 
> On Tue, 15 Jan 2002, Davide Libenzi wrote:

[...]

k33p h4ck1n6
  René

-- 
René Rebe (Registered Linux user: #248718 <http://counter.li.org>)

eMail:    rene.rebe@gmx.net
          rene@rocklinux.org

Homepage: http://drocklinux.dyndns.org/rene/

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.
