Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288325AbSATLzs>; Sun, 20 Jan 2002 06:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288338AbSATLzj>; Sun, 20 Jan 2002 06:55:39 -0500
Received: from sproxy.gmx.de ([213.165.64.20]:12824 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S288327AbSATLzd>;
	Sun, 20 Jan 2002 06:55:33 -0500
Message-ID: <3C4ABE6B.2C04DA74@gmx.de>
Date: Sun, 20 Jan 2002 12:56:11 +0000
From: **** <abdank@gmx.de>
X-Mailer: Mozilla 4.78 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Intel SRCU31 - i2o_core hangs
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hardware: intel sbt2, 2 x pIII xeon, intel srcu31 raid controller
os: rh 6.2
kernel: 2.4.17

modprobe i2o_block (inmod i2o_core) & computer hangs,
i have rewrite it from a screen:

Unabel to handle kernel paging request at virtual address 0009f808
printong eip:
f8895f5f
*pde = 00000000
Oops: 0000
CPU: 1
EIP: 0010:[<f8895f5f>] not tainted
EFLAGS: 00010206
...
Call Trace: [<f88930fc>] [<c0108488>] [<c0108679>] [<c0105200>]
[<c0105200>] [<c010a718>] [<c0105200>] [<c0105200>] [<c01052cc>]
[<c0105292>]
[<c0115a8e>]
...
<0>Kernel panic: Aiee, killing interupt handler!
In interupt handler - not syncing

now computer hangs
is it hardware or software problem ?
i have no idea what's going on


