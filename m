Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131307AbRDKFye>; Wed, 11 Apr 2001 01:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131323AbRDKFyY>; Wed, 11 Apr 2001 01:54:24 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:38929 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S131307AbRDKFyP>; Wed, 11 Apr 2001 01:54:15 -0400
Message-ID: <3AD46091.C43A413@ntsp.nec.co.jp>
Date: Wed, 11 Apr 2001 13:48:01 +0000
From: "Adrian V. Bono" <adrianb@ntsp.nec.co.jp>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: ppp performance degradation?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Could anyone please explain the major changes to the ppp module from
2.4.1 to 2.4.3? I've noticed that ppp performance isn't as fast as it
was using 2.4.1, and after a week using 2.4.3 i've concluded that ppp is
definitely slower. I've looked at the ppp_* files but so far the only
changes i saw were ppp_cleanup() being made static, and a new line added
to ppp_generic.c. Perhaps the major changes are in the rest of the
network code?

Adrian
