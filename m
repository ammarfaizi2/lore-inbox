Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264879AbTFQS1d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 14:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264880AbTFQS1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 14:27:33 -0400
Received: from pat.uio.no ([129.240.130.16]:37106 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264879AbTFQS1c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 14:27:32 -0400
To: Frank Cusack <fcusack@fcusack.com>
Cc: torvalds@transmeta.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs_unlink() again, and trivial nfs_fhget
References: <20030617051408.A17974@google.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 17 Jun 2003 11:41:18 -0700
In-Reply-To: <20030617051408.A17974@google.com>
Message-ID: <shs1xxsr1gx.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Frank Cusack <fcusack@fcusack.com> writes:

     > The first one didn't make it into 2.5.71/72, but is
     > necessary. :-)

Why are you doing this in the VFS?

There is already code to handle this case in the NFS filesystem code
itself. If you think that code is wrong then make an argument for
changing it, and send me a patch.

Cheers,
  Trond
