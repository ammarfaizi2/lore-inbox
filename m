Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132536AbRDNUKt>; Sat, 14 Apr 2001 16:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132537AbRDNUKa>; Sat, 14 Apr 2001 16:10:30 -0400
Received: from ip166-128.fli-ykh.psinet.ne.jp ([210.129.166.128]:22212 "EHLO
	standard.erephon") by vger.kernel.org with ESMTP id <S132536AbRDNUKY>;
	Sat, 14 Apr 2001 16:10:24 -0400
Message-ID: <3AD92D3B.EBBFC504@yk.rim.or.jp>
Date: Sun, 15 Apr 2001 14:10:19 +0900
From: Ishikawa <ishikawa@yk.rim.or.jp>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: "uname -p" prints unknown for Athlon K7 optimized kernel?
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On my athlong K7 optimized kernel prints "unknown" fir oricessir type.
(I have not realized what this "unknown" stood for until today.)

 #uname -p
unknown
#uname -a
Linux duron 2.4.3 #2 Fri Apr 6 04:38:35 JST 2001 i686 unknown

It would be nice to have the processor name printed.

Is this kernel configuration procedure issue or
`uname` problem?

# which uname
/bin/uname
# file /bin/uname
/bin/uname: ELF 32-bit LSB executable, Intel 80386, version 1,
dynamically linked (uses shared libs), stripped
# uname --version
uname (GNU sh-utils) 2.0
Written by David MacKenzie.

Copyright (C) 1999 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is
NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE.
#





