Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbTK1BBx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 20:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbTK1BBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 20:01:53 -0500
Received: from pat.uio.no ([129.240.130.16]:5275 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261775AbTK1BBw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 20:01:52 -0500
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Locking over NFS
References: <20031127230937.GA23147@werewolf.able.es>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 27 Nov 2003 20:01:43 -0500
In-Reply-To: <20031127230937.GA23147@werewolf.able.es>
Message-ID: <shsu14pz4p4.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == J A Magallon <J.A.> writes:

     > Hi all...  Is locking via lockf/fcntl supposed to work over NFS
     > mounted volumes in 2.4 ?  I can't get it to work, even if

Yes, it works just fine.

You're probably failing to run rpc.statd or something like that. See
the NFS FAQ & HOWTO on http://nfs.sourceforge.net

Cheers,
  Trond
