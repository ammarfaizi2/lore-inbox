Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbUKBVkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbUKBVkU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 16:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbUKBVjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 16:39:43 -0500
Received: from pat.uio.no ([129.240.130.16]:2251 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262212AbUKBVgo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 16:36:44 -0500
Subject: Re: nfs stale filehandle issues with 2.6.10-rc1 in-kernel server
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Brad Campbell <brad@wasp.net.au>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <4187E4E1.5080304@pobox.com>
References: <41877751.502@wasp.net.au>
	 <1099413424.7582.5.camel@lade.trondhjem.org>  <4187E4E1.5080304@pobox.com>
Content-Type: text/plain
Date: Tue, 02 Nov 2004 13:36:04 -0800
Message-Id: <1099431364.7854.17.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0.326, required 12,
	RCVD_NUMERIC_HELO 0.33)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ty den 02.11.2004 Klokka 14:49 (-0500) skreiv Jeff Garzik:

> This is readily reproducible with rsync -- I just boot to an earlier 
> version of the kernel on the NFS client, and the stale filehandle 
> problems go away.

Huh? The client cannot generate stale filehandle errors: only the server
does that.
Have you got a binary tcpdump that shows the problem?

Cheers
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

