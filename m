Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132374AbQKZQk2>; Sun, 26 Nov 2000 11:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132144AbQKZQkS>; Sun, 26 Nov 2000 11:40:18 -0500
Received: from inet-smtp3.oracle.com ([205.227.43.23]:32687 "EHLO
        inet-smtp3.oracle.com") by vger.kernel.org with ESMTP
        id <S132348AbQKZQkL>; Sun, 26 Nov 2000 11:40:11 -0500
Message-ID: <3A2135C3.7E50CEFB@oracle.com>
Date: Sun, 26 Nov 2000 17:09:39 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18pre22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: alan@lxorguk.ukuu.org.uk, bernds@redhat.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: gcc 2.95.2 is buggy
In-Reply-To: <UTC200011240157.CAA140709.aeb@aak.cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(cough) doesn't reproduce on my 2.95.2...

[asuardi@princess misc]$ vi bug.c

(cut'n'paste from Andries' email)

[asuardi@princess misc]$ gcc -Wall -O2 -o bug bug.c
[asuardi@princess misc]$ ./bug
0x0
[asuardi@princess misc]$ gcc -v
Reading specs from /usr/lib/gcc-lib/i686-pc-linux-gnu/2.95.2/specs
gcc version 2.95.2 19991024 (release)

'bug' binary available upon request.


Ciao,

--alessandro      <alessandro.suardi@oracle.com> <asuardi@uninetcom.it>

Linux:  kernel 2.2.18p22/2.4.0-t11 glibc-2.1.94 gcc-2.95.2 binutils-2.10.0.33
Oracle: Oracle8i 8.1.6.1.0 Enterprise Edition for Linux
motto:  Tell the truth, there's less to remember.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
