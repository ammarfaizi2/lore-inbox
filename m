Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276956AbRJQQ3J>; Wed, 17 Oct 2001 12:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276957AbRJQQ3A>; Wed, 17 Oct 2001 12:29:00 -0400
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:50958 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S276956AbRJQQ2p>; Wed, 17 Oct 2001 12:28:45 -0400
X-Apparently-From: <rajeev?bector@yahoo.com>
From: "Rajeev Bector" <rajeev_bector@yahoo.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: ptrace question
Date: Wed, 17 Oct 2001 09:23:38 -0700
Message-ID: <GIEMIEJKPLDGHDJKJELAEEBLCNAA.rajeev_bector@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2479.0006
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a question on the ptrace system call
implementation:

In kernel/ptrace.c in the function access_one_page(),
why is read access denied to pages which are
marked PG_reserved ?

I have some pages in my driver which are reserved
and memory mapped to user applications which I'd
like to access in gdb.

Any clues to what is the risk if I were to enable
accessing of pages which are marked "reserved"

Thanks in advance !
Rajeev


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

