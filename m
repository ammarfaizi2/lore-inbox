Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbVBGWwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVBGWwE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 17:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVBGWuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 17:50:06 -0500
Received: from pat.uio.no ([129.240.130.16]:12539 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261291AbVBGWsx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 17:48:53 -0500
Subject: Re: Irix NFS server usual problem
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Olivier Galibert <galibert@pobox.com>
Cc: "Hack inc." <linux-kernel@vger.kernel.org>
In-Reply-To: <20050207221638.GA18723@dspnet.fr.eu.org>
References: <20050207221638.GA18723@dspnet.fr.eu.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 07 Feb 2005 17:48:44 -0500
Message-Id: <1107816524.9970.8.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 8BIT
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0.008, required 12,
	autolearn=disabled, AWL 0.01)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

må den 07.02.2005 Klokka 23:16 (+0100) skreiv Olivier Galibert:
> I'm starting to install some fedora core 3 systems in an environment
> where 64bits SGIs are still serving the home directories.  They have
> the bug/feature that required the 2.4 patch to hack the 64bits
> cookies[1].  The 2.6 kernel I just found still can't compensate by
> itself for the issue.
> 
> Is there an easy way to fix that?

Have you applied SGI's IRIX patches to your server (the one that makes
the cookies take 32-bit values)?

Alternatively, you can forward-port the old 2.4.x cookie hack to 2.6.x
(that should be fairly trivial to do). You can find the patch on

http://client.linux-nfs.org/Linux-2.4.x/2.4.26/linux-2.4.26-02-seekdir.dif

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

