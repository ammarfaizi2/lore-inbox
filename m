Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269817AbRHZNSK>; Sun, 26 Aug 2001 09:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269975AbRHZNRv>; Sun, 26 Aug 2001 09:17:51 -0400
Received: from spoolm2.tiscalinet.be ([212.35.2.51]:37894 "EHLO
	spoolm2.tiscalinet.be") by vger.kernel.org with ESMTP
	id <S269817AbRHZNRq>; Sun, 26 Aug 2001 09:17:46 -0400
Message-ID: <3B88F7F7.26BAC09B@freebel.net>
Date: Sun, 26 Aug 2001 13:21:59 +0000
From: Soete Joel <joel.soete@freebel.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: NTFS support broken?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

Not sure it is a bug because of my install between potato and woody
But when I recompile kernel 2.4.9 I had to add into
linux/fs/ntfs/unistr.h: #include <linux/kernel.h>
otherwise building the kernel complains because of lack of min function
reference.

Joel

PS: Forget if already mentioned or evident corruption of my install.
