Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161068AbVLWWBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161068AbVLWWBG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 17:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161069AbVLWWBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 17:01:05 -0500
Received: from pat.uio.no ([129.240.130.16]:28054 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1161068AbVLWWBC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 17:01:02 -0500
Subject: Re: nfs insecure_locks / Tru64 behaviour
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Bernd Eckenfels <be-mail2005@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051223214138.GA25727@lina.inka.de>
References: <E1EprNK-0005ZC-00@calista.inka.de>
	 <1135371520.8555.2.camel@lade.trondhjem.org>
	 <20051223214138.GA25727@lina.inka.de>
Content-Type: text/plain
Date: Fri, 23 Dec 2005 23:00:54 +0100
Message-Id: <1135375254.8555.49.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.47, required 12,
	autolearn=disabled, AWL 1.48, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-23 at 22:41 +0100, Bernd Eckenfels wrote:
> On Fri, Dec 23, 2005 at 09:58:40PM +0100, Trond Myklebust wrote:
> > Huh? No it doesn't. The Linux NLM server requires that the client
> > authenticate using AUTH_SYS (unless you use insecure_locks), but it
> > certainly doesn't require you to have root privileges. That would
> > violate POSIX locking rules.
> 
> Yes, however True64 does not authenticate (properly), thats why you need the
> option if you want to do locking.

Sure, however his problem doesn't appear to be related to POSIX/fcntl
locking on the file itself, but rather to access checking on the parent
directory.

Cheers,
  Trond

