Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130021AbQLMXkc>; Wed, 13 Dec 2000 18:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131091AbQLMXkW>; Wed, 13 Dec 2000 18:40:22 -0500
Received: from saltlake.cheek.com ([207.202.196.152]:62214 "EHLO
	saltlake.cheek.com") by vger.kernel.org with ESMTP
	id <S130021AbQLMXkE>; Wed, 13 Dec 2000 18:40:04 -0500
Message-ID: <3A38019E.925D809B@cheek.com>
Date: Wed, 13 Dec 2000 15:09:18 -0800
From: Joseph Cheek <joseph@cheek.com>
X-Mailer: Mozilla 4.73C-CCK-MCD Caldera Systems OpenLinux [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: test12 + initrd = swapper at 99.8% CPU time
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

i'm using test12 to perform a clean linux install.  as soon as i get to
a command prompt, ps axufw shows swapper at 99.8% CPU usage.  this
didn't repro with test11, and doesn't repro if i don't use an initrd.

my load avg stays above 1 even if nothing [a couple gettys and a shell]
is running.

what can i do to debug this?  any ideas?

--
thanks!

joe

--
Joseph Cheek, Sr Linux Consultant, Linuxcare | http://www.linuxcare.com/
Linuxcare.  Support for the Revolution.      | joseph@linuxcare.com
CTO / Acting PM, Redmond Linux Project       | joseph@redmondlinux.org
425 990-1072 vox [1074 fax] 206 679-6838 pcs | joseph@cheek.com



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
