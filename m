Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135647AbRDSMtm>; Thu, 19 Apr 2001 08:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135649AbRDSMtc>; Thu, 19 Apr 2001 08:49:32 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:52236 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135647AbRDSMtY>; Thu, 19 Apr 2001 08:49:24 -0400
Subject: Re: Kernel panics on raw I/O stress test
To: t-kawano@ebina.hitachi.co.jp
Date: Thu, 19 Apr 2001 13:50:36 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010419210153Z.t-kawano@ebina.hitachi.co.jp> from "Takanori Kawano" at Apr 19, 2001 09:01:53 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14qDtP-00077x-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When I ran raw I/O SCSI read/write test with 2.4.1 kernel 
> on our IA64 8way SMP box, kernel paniced and following 
> message was displayed.
> 
>   Aiee, killing interrupt handler!
> 
> (1) Wait in rw_raw_dev() while io_count is positive. 

Stephen submitted a chunk of raw i/o fixes which are in recent -ac kernels.
I don't know if Linus has merged them offhand. But 2.4.1 raw is definitely
not watertight


