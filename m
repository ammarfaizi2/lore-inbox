Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267186AbUIEUKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267186AbUIEUKT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 16:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267189AbUIEUKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 16:10:18 -0400
Received: from pat.uio.no ([129.240.130.16]:37514 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S267186AbUIEUKO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 16:10:14 -0400
Subject: Re: why do i get "Stale NFS file handle" for hours?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Sven =?ISO-8859-1?Q?K=F6hler?= <skoehler@upb.de>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
In-Reply-To: <413B121B.2070101@upb.de>
References: <chdp06$e56$1@sea.gmane.org>
	 <1094348385.13791.119.camel@lade.trondhjem.org>  <413A7119.2090709@upb.de>
	 <1094349744.13791.128.camel@lade.trondhjem.org>  <413A789C.9000501@upb.de>
	 <1094353267.13791.156.camel@lade.trondhjem.org>  <413B121B.2070101@upb.de>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1094415006.8081.6.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 05 Sep 2004 16:10:06 -0400
Content-Transfer-Encoding: 8BIT
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På su , 05/09/2004 klokka 09:18, skreiv Sven Köhler:

> So there should be a filesystem mounted to /proc/fs/nfsd? This isn't the 
> case on my machine. Should the init-script do a simple "mount -t nfsd 
> none /proc/fs/nfsd"? Than this would be a Bug of my distribution (Gentoo).

Yes... See the manpage for "exportfs".

Cheers,
  Trond

