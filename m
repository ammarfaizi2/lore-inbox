Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311948AbSEMKz5>; Mon, 13 May 2002 06:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312169AbSEMKz4>; Mon, 13 May 2002 06:55:56 -0400
Received: from eunhasu.kjist.ac.kr ([203.237.32.200]:24221 "HELO kjist.ac.kr")
	by vger.kernel.org with SMTP id <S311948AbSEMKzz>;
	Mon, 13 May 2002 06:55:55 -0400
Message-ID: <3CDF9BB1.8000608@kjist.ac.kr>
Date: Mon, 13 May 2002 19:55:45 +0900
From: "G. Hugh Song" <ghsong@kjist.ac.kr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: ko, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Memory fault with 2.4.19-pre8aa2 2.4.9-pre8ac1 on the Athlon SMP
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

For two days, I am constantly observing this error
with both 2.4.19-pre8aa2 and 2.4.9-pre8ac1 on the Athlon SMP
with two 1900+ CPUs running at 1.6GHz with 2GB DDR
registered DRAMs. ASUS A7M266-D with their newest
official BIOS 1.005a.

$ latex fw.tex

[...snip...]

[756] [757] [758] [759]
Overfull \hbox (4.56194pt too wide) in paragraph at lines 8190--8194
[]\OT1/ppl/m/n/12 The spec-tral dis-tri-bu-tion of such a noise in an
non-equil
ibrium medium un-der pump-
[760] (gnu.d/curtot.tex)Memory fault
11.25s real 10.82s user 0.25s system

As you can observe it here, it happens during LaTeX processing on a
a big file.
I ran this process more than 20 times with 2.4.19-pre6aa1 all successfully.
I believe that there is a problem somewhere with some memory
management stuffs either in -pre7 or in -pre8.
Absolutely no message is recorded in the /var/log/message file.
That is strange.

I have not checked the above kernels on 2.4.19-pre8aa2 and 2.4.19-pre8ac1
compiled for Pentium 4, yet. Before investing further, I think I need
to report about it anyway.

Thank you.

Regards to all kernel developers.

G. Hugh Song


