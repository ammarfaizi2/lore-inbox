Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261796AbVCHGwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbVCHGwx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 01:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbVCHGvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 01:51:32 -0500
Received: from pat.uio.no ([129.240.130.16]:6358 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261834AbVCHGsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 01:48:09 -0500
Subject: Re: NFS client bug in 2.6.8-2.6.11
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Bernardo Innocenti <bernie@develer.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Neil Conway <nconway_kernel@yahoo.co.uk>, nfs@lists.sourceforge.net
In-Reply-To: <422D485F.5060709@develer.com>
References: <422D2FDE.2090104@develer.com>
	 <1110259831.11712.1.camel@lade.trondhjem.org>
	 <422D485F.5060709@develer.com>
Content-Type: text/plain
Date: Tue, 08 Mar 2005 01:47:55 -0500
Message-Id: <1110264475.11712.30.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.95, required 12,
	autolearn=disabled, AWL 2.00, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ty den 08.03.2005 Klokka 07:38 (+0100) skreiv Bernardo Innocenti:
> Trond Myklebust wrote:
> > ty den 08.03.2005 Klokka 05:53 (+0100) skreiv Bernardo Innocenti:
> > 
> >>Appears to be a client bug.
> > 
> > Why?
> 
> Two clients started showing the problem after
> being upgraded from FC2 to FC3, while the server
> remained unchanged.

Can you produce tcpdumps to back that up?

Neil's problem appeared rather to be server-related. Neither of us could
reproduce his problem when the server was exporting an XFS partition.

The other thing to try is to turn off subtree checking on the server.

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

