Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263743AbUISUcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbUISUcf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 16:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbUISUcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 16:32:35 -0400
Received: from pat.uio.no ([129.240.130.16]:31622 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263743AbUISUcc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 16:32:32 -0400
Subject: Re: 2.6.9-rc2 hangs in posix_locks_deadlock
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "Vladimir B. Savkin" <master@sectorb.msk.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040919200527.GA7184@tentacle.sectorb.msk.ru>
References: <20040919160342.GA26409@tentacle.sectorb.msk.ru>
	 <20040919200527.GA7184@tentacle.sectorb.msk.ru>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1095625531.7860.59.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 19 Sep 2004 13:32:08 -0700
Content-Transfer-Encoding: 8BIT
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På su , 19/09/2004 klokka 13:05, skreiv Vladimir B. Savkin:
> > 
> > Today I managed to see the output of Alt+SysRq+P on the
> > hanged box and write down call trace (from screen, so it is incomplete).
> > 
> > EIP (c015da89) was in function posix_locks_deadlock,
> > and the call trace was:
> >  __posix_lock_file
> >  fcntl_setlk

What filesystems are you using on that box?

Cheers,
  Trond

