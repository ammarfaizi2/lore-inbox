Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262088AbVBVOaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262088AbVBVOaY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 09:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262309AbVBVOaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 09:30:23 -0500
Received: from pat.uio.no ([129.240.130.16]:28878 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262088AbVBVOaT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 09:30:19 -0500
Subject: Re: [patch 11/13] Client side of nfsacl
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Neil Brown <neilb@cse.unsw.edu.au>, Olaf Kirch <okir@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Buck Huppmann <buchk@pobox.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1109079688.6102.264.camel@winden.suse.de>
References: <20050122203326.402087000@blunzn.suse.de>
	 <20050122203620.005569000@blunzn.suse.de>
	 <1108489757.10073.46.camel@lade.trondhjem.org>
	 <1109079688.6102.264.camel@winden.suse.de>
Content-Type: text/plain
Date: Tue, 22 Feb 2005 09:13:56 -0500
Message-Id: <1109081637.9839.6.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.457, required 12,
	autolearn=disabled, AWL 1.54, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ty den 22.02.2005 Klokka 14:41 (+0100) skreiv Andreas Gruenbacher:
> On Tue, 2005-02-15 at 18:49, Trond Myklebust wrote:
> > I suggest you rather do the same thing we're doing for the NFSv4 acls,
> > and provide an nfsv3-specific struct inode_operations that points to
> > nfsv3-specific {get,set,list}xattr functions.
> 
> Okay, that requires iops for file, dir, and others. How about the
> attached patch?

That's fine by me.

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

