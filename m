Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWDTQl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWDTQl4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 12:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWDTQlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 12:41:55 -0400
Received: from pat.uio.no ([129.240.10.6]:47585 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751089AbWDTQly (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 12:41:54 -0400
Subject: Re: NFS bug?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Robert Merrill <grievre@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b3be17f30604200937l7cfaca8evcc17f6ecd72f643e@mail.gmail.com>
References: <b3be17f30604200937l7cfaca8evcc17f6ecd72f643e@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 20 Apr 2006 12:41:44 -0400
Message-Id: <1145551304.8136.5.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.928, required 12,
	autolearn=disabled, AWL 1.07, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-20 at 09:37 -0700, Robert Merrill wrote:
> we have an SMP login server we just recently switched to debian
> testing from FreeBSD and it's giving us a little trouble.
> 
> it mounts its /home on a seperate machine, which is still running BSD,
> over a NIC-to-NIC 1000BASE-T link.
> 
> We've found the following bug exists in 2.6.15 and .16: If a directory
> under /home is readable but not executable, a call to getdents64() on
> it will kill the process with an invalid operand error in
> __copy_from_user_ll

> has this been fixed already, and is there a patch which is readily applicable?

No idea. Can you supply us with a strace of the problem?

> we're not using the latest kernel, unfortunately, because it has lockd problems.

Care to elaborate?

Cheers,
  Trond

