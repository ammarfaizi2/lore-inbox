Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262581AbUKEDK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262581AbUKEDK2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 22:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbUKEDK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 22:10:27 -0500
Received: from pat.uio.no ([129.240.130.16]:42717 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262581AbUKEDKO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 22:10:14 -0500
Subject: Re: nfs stale filehandle issues with 2.6.10-rc1 in-kernel server
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Brad Campbell <brad@wasp.net.au>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <418AEC14.3040605@pobox.com>
References: <41877751.502@wasp.net.au>
	 <1099413424.7582.5.camel@lade.trondhjem.org>  <4187E4E1.5080304@pobox.com>
	 <1099431364.7854.17.camel@lade.trondhjem.org>  <418AEC14.3040605@pobox.com>
Content-Type: text/plain
Date: Thu, 04 Nov 2004 19:09:52 -0800
Message-Id: <1099624193.25951.17.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 04.11.2004 Klokka 21:57 (-0500) skreiv Jeff Garzik:

> Not saying that the client is _generating_ the stale filehandle errors, 
> only saying that they appear to go away when I boot the _client_ into 
> older 2.6.9 kernels.

That would point to some pretty nasty memory corruption issues on the
client then (affecting the cached filehandle in the inode itself).

So... I can't see that any NFS client changes have been pushed to Linus
after the release of 2.6.9-rc2. Is the latter afflicted with the ESTALE
problem?

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

