Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbWCLEKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWCLEKT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 23:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWCLEKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 23:10:19 -0500
Received: from pat.uio.no ([129.240.130.16]:5857 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750868AbWCLEKS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 23:10:18 -0500
Subject: Re: NFS client hangs under certain circumstances on SMP machine
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Olivier Croquette <ocroquette@free.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44128861.20409@free.fr>
References: <5LjNF-1Q2-7@gated-at.bofh.it>  <44128861.20409@free.fr>
Content-Type: text/plain
Date: Sat, 11 Mar 2006 23:10:06 -0500
Message-Id: <1142136606.29623.8.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.206, required 12,
	autolearn=disabled, AWL 1.61, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-11 at 09:20 +0100, Olivier Croquette wrote:
> Olivier Croquette wrote:
> 
> > However, when I regenerate the file under Windows again (ie. I overwrite
> > the old files), and I try to compile the files again under Linux, "make"
> > hangs simply in D state:
> > 
> > # ps aux | grep make
> > user 7177 0.0  0.0 1984 760 pts/1 D+ 16:13 0:00 make -f myMakefile
> 
> I have upgraded to kernel 2.6.15 and it could not reproduce the problem 
> since.
> 
> Is it an effect of nfs-fix-client-hang-due-to-race-condition.patch?

Have you tried backing that patch out to see?

Cheers,
  Trond

