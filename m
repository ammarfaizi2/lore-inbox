Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312361AbSC0Gu6>; Wed, 27 Mar 2002 01:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312678AbSC0Gus>; Wed, 27 Mar 2002 01:50:48 -0500
Received: from ccs.covici.com ([209.249.181.196]:43905 "EHLO ccs.covici.com")
	by vger.kernel.org with ESMTP id <S312361AbSC0Guh>;
	Wed, 27 Mar 2002 01:50:37 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.5.7 process accounting bombs out
From: John Covici <covici@ccs.covici.com>
Date: Wed, 27 Mar 2002 01:50:35 -0500
Message-ID: <m3bsdamrlw.fsf@ccs.covici.com>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) Emacs/21.1.90
 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whenever I try to start the init script for process accounting I get
the following error:

Mar 27 00:02:02 ccs kernel: kernel BUG at acct.c:169!
Mar 27 00:02:02 ccs kernel: invalid operand: 0000
Mar 27 00:02:02 ccs kernel: CPU:    0
Mar 27 00:02:02 ccs kernel: EIP:    0010:[acct_file_reopen+8/208]
Not tainted
Mar 27 00:02:02 ccs kernel: EFLAGS: 00010246

The system doesn't go down, but is there any way to fix this?

Thanks.

-- 
         John Covici
         covici@ccs.covici.com
