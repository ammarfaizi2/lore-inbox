Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265837AbRF1NoE>; Thu, 28 Jun 2001 09:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265844AbRF1Nnz>; Thu, 28 Jun 2001 09:43:55 -0400
Received: from gate.westel900.hu ([194.176.224.33]:7482 "EHLO
	gate.westel900.hu") by vger.kernel.org with ESMTP
	id <S265837AbRF1Nnj>; Thu, 28 Jun 2001 09:43:39 -0400
Date: Thu, 28 Jun 2001 15:39:54 +0200
From: csani@lme.linux.hu
To: linux-kernel@vger.kernel.org
Subject: Error while making 2.4.5 bzImage with CONFIG_MPENTIUMIII=y
Reply-To: csani@lme.linux.hu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Message-ID: <15Fc3N-0004je-00@gate.westel900.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the config file:

http://www.holanyi.hu/config

produced with make menuconfig on a vanilla tree;
and this is the log file:

http://www.holanyi.hu/bzImage.log

of the command:

time make dep clean bzImage modules moduels_install 2>&1 | tee bzImage.log

The errors do not occur if I switch on SMP. Howver, I would like to get out
the most of my PIII 500 and would not like to use SMP and would also like to
use APM stuff.
Is this a known problem with 2.4.5? Sorry if yes.
Anyway, I could not find relevant info in the archives of this list about
this issue.

Is there hope I will be able to compile a suitable kernel for this PIII?

Thanks

Csan

PS: Please Cc: me. However, I will be monitoring the archives, so I will
catch your mails. :)
