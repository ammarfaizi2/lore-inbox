Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279472AbRKAS2b>; Thu, 1 Nov 2001 13:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279473AbRKAS2V>; Thu, 1 Nov 2001 13:28:21 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:6292 "EHLO softhome.net")
	by vger.kernel.org with ESMTP id <S279472AbRKAS2I>;
	Thu, 1 Nov 2001 13:28:08 -0500
Message-ID: <3BE194BB.7090207@softhome.net>
Date: Thu, 01 Nov 2001 18:30:19 +0000
From: Ricardo Martins <thecrown@softhome.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en, pt
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: "unkillable processes" in linux 2.4.11 to 2.4.14-pre6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using Linux kernel 2.4.10, and since the fatidic 2.4.11 release ( i
tried 2.4.11 (one day :)))) 2.4.12, 2.4.13 and 2.4.14-pre6) I get the
same bug on and on (that means I can reproduce the experience and obtain
the same results).

Procedure
In X windows (version 4.1.0 compiled from the sources) when writing
"exit" in xterm to close the terminal emulator, the window freezes, and
from that moment on, every process becomes "unkillable", including xterm
and X (ps also freezes), and there's no way to shutdown GNU/Linux in a
sane way (must hit reset or poweroff).

Environment
I used Glibc 2.2.4 and GCC 3.0.1 (tried with 2.95.3, obtained the same
results).

The odd thing is, that with the same configuration, kernel 2.4.10 works
just fine, but every other release since then ends up doing the same
thing (the system can't maintain integrity after writing "exit" and
hiting enter in xterm).

Please help me, I getting slightly mad with the situation.

Ricardo Martins


