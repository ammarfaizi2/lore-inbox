Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261942AbRE2BH3>; Mon, 28 May 2001 21:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261947AbRE2BHT>; Mon, 28 May 2001 21:07:19 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:13025 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S261942AbRE2BHL>;
	Mon, 28 May 2001 21:07:11 -0400
Message-ID: <3B12EE32.9B35F89F@mandrakesoft.com>
Date: Mon, 28 May 2001 20:32:50 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Plain 2.4.5 VM...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ouch!  When compiling MySql, building sql_yacc.cc results in a ~300M
cc1plus process size.  Unfortunately this leads the machine with 380M of
RAM deeply into swap:

Mem:   381608K av,  248504K used,  133104K free,       0K shrd,     192K
buff
Swap:  255608K av,  255608K used,       0K free                  215744K
cached

Vanilla 2.4.5 VM.

-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
