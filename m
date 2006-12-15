Return-Path: <linux-kernel-owner+w=401wt.eu-S1752978AbWLORUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752978AbWLORUd (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 12:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752984AbWLORUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 12:20:33 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40636 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752977AbWLORUc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 12:20:32 -0500
Date: Fri, 15 Dec 2006 17:28:52 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.20-rc1
Message-ID: <20061215172852.2d4dcaa6@localhost.localdomain>
In-Reply-To: <4582D246.3010701@tmr.com>
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org>
	<4582D246.3010701@tmr.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Dec 2006 11:50:14 -0500
Bill Davidsen <davidsen@tmr.com> wrote:
> Did I miss an alternate method of handling ftape devices, or are these 
> old beasts now unsupported? I occasionally have to be able to handle 
> that media, since the industrial device using ftape for control updates 
> cost more than a small house.

Do you have hardware and the time to at least test cleanups ?

> I can obviously keep an old slow machine to do the job, but I'd like to 
> know if I need to.

The assumption was that since in 2.6 it was so ancient and unloved that
nobody had even seen an ftape device this century. If it is still being
used and you can test cleanups then the removal should be reverted

Alan
