Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262669AbRFBTSV>; Sat, 2 Jun 2001 15:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262672AbRFBTSK>; Sat, 2 Jun 2001 15:18:10 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:12304 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262667AbRFBTR6>; Sat, 2 Jun 2001 15:17:58 -0400
Subject: Re: Warning in ac6
To: sjones@ossm.edu (Sean Jones)
Date: Sat, 2 Jun 2001 20:16:09 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <3B192DAB.FF8FB3B5@ossm.edu> from "Sean Jones" at Jun 02, 2001 01:17:15 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E156Gsb-00022v-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've recieved this warning in the past several ac versions both 2.4.5
> and 2.4.4. Here is the out put from the compiler:

This is a compiler bug. Its a harmless and incorrect warning

> Also the file /proc/sys/fs/binfmt_misc seems to be missing on my
> machine. How would I remedy this problem?

mount it. In -ac the binfmt_misc driver is its own file system

