Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751385AbWJQSlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWJQSlR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 14:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWJQSlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 14:41:17 -0400
Received: from pat.uio.no ([129.240.10.4]:13258 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751385AbWJQSlQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 14:41:16 -0400
Subject: Re: nfs file locking broken
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "Robert W. Fuller" <garbageout@sbcglobal.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <45352148.4020706@sbcglobal.net>
References: <453145DD.3040501@sbcglobal.net>
	 <45352148.4020706@sbcglobal.net>
Content-Type: text/plain
Date: Tue, 17 Oct 2006 14:40:55 -0400
Message-Id: <1161110455.5559.16.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.829, required 12,
	autolearn=disabled, AWL 1.17, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-17 at 14:30 -0400, Robert W. Fuller wrote:
> Robert W. Fuller wrote:
> > I tried to upgrade from 2.6.16.27 to 2.6.17.13.  I have also tried
> > 2.6.18.1.  I discovered NFS file locking no longer works between a Linux
> > client and an OpenBSD server.  For example, gtk-gnutella gets the
> > following error:
> > 
> > 06-10-14 15:50:19 (WARNING): fcntl(8, F_SETLK, ...) failed for
> > "/home/edison/.gtk-gnutella/gtk-gnutella.pid": Permission denied
> > 
> > gpg hangs waiting for a lock for ~/.gnupg/random_seed
> 
> Maybe the thing to do is to Cc: the NFS guy on this?  Anybody else have
> any suggestions?
> 
> Is there a known fundamental change in the Linux NFS client that would
> break file locking between a Linux NFS client and an OpenBSD-3.8 NFS
> server?    Is OpenBSD-3.8 somehow broken with respect to new behavior in
> the Linux NFS client?
> 
> This is very reproducible.  File locking works with 2.6.16.27.  Sometime
> thereafter it ceased to work.  There are no configuration changes to
> /etc or anything like that....  For me, it's a simple matter of choosing
> a working kernel from the GRUB menu or a broken kernel.

File locking works fine for me, both against Linux boxes and others. I
don't have any OpenBSD servers to test, though.

Have you tried using something like ethereal/wireshark in order to sniff
the wire?

Cheers,
  Trond

