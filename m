Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130073AbQKGXN1>; Tue, 7 Nov 2000 18:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130202AbQKGXNR>; Tue, 7 Nov 2000 18:13:17 -0500
Received: from k2.llnl.gov ([134.9.1.1]:42730 "EHLO k2.llnl.gov")
	by vger.kernel.org with ESMTP id <S130073AbQKGXNG>;
	Tue, 7 Nov 2000 18:13:06 -0500
Message-ID: <3A08455E.F3583D1B@scs.ch>
Date: Tue, 07 Nov 2000 10:09:34 -0800
From: Reto Baettig <baettig@scs.ch>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.17ext3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Alpha SMP problem
Content-Type: multipart/mixed;
 boundary="------------ECD6238D6E478D72F2A72E2C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------ECD6238D6E478D72F2A72E2C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi

I have a problem whith Alpha SMP's which seems to be kernel-related. I
discussed this on the bug-glibc list but everybody seems to agree that
it cannot be a libc problem.

I attached a little testprogram which reproduces the bug in < 1Minute. 
BUT: IT MUST BE STARTED AT LEAST TWICE!

The strange thing is that a single instance of the program runs just
fine. When I start the program a second time, I get segfaults and/or
stuck threads.

We could reproduce this behaviour on different Machines, both with linux
2.2.14 and 2.4.0-test10, but 
ONLY ON ALPHA SMP MACHINES.

Here's my configuration:

Linux reto1 2.4.0-test10 #2 SMP Tue Oct 31 19:39:51 PST 2000 alpha
unknown
                            ^^^                              ^^^^^
Kernel modules         2.3.19
Gnu C                  egcs-2.91.66
Gnu Make               3.78.1
Binutils               2.9.5.0.22
Linux C Library        2.1.3
Dynamic linker         ldd (GNU libc) 2.1.3
Procps                 2.0.6
Mount                  2.10f
Net-tools              1.54
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         nfs lockd sunrpc

Any ideas?

Please tell me when you need more information, or give me some pointers
where I could start to dig...

TIA

Reto
--------------ECD6238D6E478D72F2A72E2C
Content-Type: application/octet-stream;
 name="malloctest.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="malloctest.tgz"

H4sIADHC+DkAA+1WW2/bNhTOK/krTtM1kJzYluxcgKQpmtVp+5D4IXWBAVtgyNJxTEwXj6KT
eIX/+w5JWZGTbH1Khw38YFji4bnf7Mvod5yKFLdeEEEYBIeH+1tBEB4c9Q4aT4vwMNgKjnpB
0O/vh71D4u/1D8ItCF7SqTUWpYokwNYkQqXEzd/yfe/+P4oPHy/OPn2BU2gPrs7Ph6Ors+GI
XwxqajpXM4lRwvno7OrT+UgTsyhNi1hhqYBzej+Gn7zq1uc8TjHKjzmTGbSnjRuIC4n8347X
YRMPtezEL2XjO/PfPzoM1/N/0D8gvrDf2++5+f8R6LY4tKDZBXTWpCss50VeikmKx3RQBfxs
MwBelYr3ZVx24plfCXwWpSrk8piFYTugTwAfaHEoTBiTE2Locs5fizxOFwnC21IlqZh0Zu+a
tGXZVcs5ls+QRYaPqEqK/GaTVu2qTWJUlijVY1rWJbUKM03nrxP6DcwRhl8vx6PPV+dngy8Q
Bpx3W6AjUzNRQiRltAR6yQsFc1kopHwlMFlCtlB4T06DUJAUaDlypEtKmpafYFMA42hRItwh
qUQo8pS05golJZ+uxZTMIdhASiNeKpGmpBnKIkPyJb+BQlaMS7ot5nNMTILTIr9hwJiajSX+
8WsjnGta29+CPVidcK5TTAGTpFzECjLMxvQK3ziLZzQKrcliesIZ+QQJpqjwhK/WTCR9W4iE
j2bjAabR0jNcyuckXKnTlbqNUh0TPUiA2beOuh2XGJMfierSQghOmjcLe+UlCt6AvvUp8IqL
gQFZIHdi5VEYw68XF5vfO1aXT85aHyFbjqt+GMemET0w9BZMF3m8Vx0ieUPeA+Nszazg/oSM
UX69R/I792trVoOW9XXeGJtTM6qpt70pAShlIX/Lt32tkTG8F8prh+QkW9V+fpSInnUmayZy
XZcWvZx6j4l+Rko4u5vRfzcvtF6YA3iviKn9ztbO12bramnLRMgmHjlEzT3Sja0/2byQKqJa
UsdiXi6k7sDImGu/o34w3sMsKql9MYc7KZSiJ3ETBw09LFGZCWfMjptXS746NTnTMW/cVf5p
8lRnYC1gKLW0Fa5JVoiowTqF69G9PPtlfHE+BC8Mevst/eXb9A6KEU2Wp0eD4h0PF88mmZ6k
sRR/ItU/xVzniWidhkFmKRtePe0xXc09qOrp75CEyflGnUi/7nUZ5UmReX7LOqe//CqMLv0N
G4zp4MMuhLZotW27rD3S8iipnc1883oR2Livd3dNz2wGFmodD83zcOfDk94xjD+oe2ywzzZP
7TyVxcS5YroVaAJ5FoncJN8UWW8noRmmtDA9YcoI4m1jL9Jxd9dW5Wktbes8VNPUyRd2fPk6
YxCCVfCQKr2/qmytF8OlKVrZHRkLx9VGsH6d/oNXtYI3+wK296CqqLg2Blh9PDWbctWwaNaO
9VSiWshcD83K/QF3cHBwcHBwcHBwcHBwcHBwcHBwcHBwcHD4f+Mv6p3CBgAoAAA=
--------------ECD6238D6E478D72F2A72E2C--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
