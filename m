Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266469AbTGEUNR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 16:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266473AbTGEUNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 16:13:17 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:31504 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP id S266469AbTGEUNQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 16:13:16 -0400
Date: Sat, 05 Jul 2003 14:27:43 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Roberto Slepetys Ferreira <slepetys@homeworks.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: Probably 2.4 kernel or AIC7xxx module trouble
Message-ID: <2279890000.1057436863@aslan.scsiguy.com>
In-Reply-To: <002501c34252$c8d10980$3300a8c0@Slepetys>
References: <4R5X.8bo.19@gated-at.bofh.it> <4Rzh.h8.25@gated-at.bofh.it> <4WSg.5H7.21@gated-at.bofh.it>
 <5h0y.5ht.25@gated-at.bofh.it> <5iIR.7Cp.11@gated-at.bofh.it> <5iIQ.7Cp.9@gated-at.bofh.it> <5jOA.14o.9@gated-at.bofh.it>
 <5lnu.2l7.13@gated-at.bofh.it> <002501c34252$c8d10980$3300a8c0@Slepetys>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi again,
> 
> I passed the parameer: nmi_watchdog=1 to the kernel at the boot.
> 
> And after about 2 hours it frozen again, but in the console I found a lot of
> messages like this:
> 
> smb_proc_readdir_log: name=\....(some directory)....\*, result=-2, rcls=1,
> err=2

Looks like your samba server is upset about some requests its getting.
These probably have nothing to do with your hang.

Did you verify that the NMI watchdog was functioning properly on your
system as outline by the NMI watchdog FAQ in the kernel source Documenation
directory?

--
Justin

