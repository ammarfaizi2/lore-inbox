Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263358AbTEMR7p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 13:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263322AbTEMR7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 13:59:33 -0400
Received: from pat.uio.no ([129.240.130.16]:56504 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263358AbTEMR6Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 13:58:24 -0400
To: miquels@cistron-office.nl (Miquel van Smoorenburg)
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 must-fix list, v2
References: <20030512155417.67a9fdec.akpm@digeo.com>
	<20030512155511.21fb1652.akpm@digeo.com>
	<1052834227.432.30.camel@dhcp22.swansea.linux.org.uk>
	<shsy91aonlt.fsf@charged.uio.no> <b9rbce$p0u$1@news.cistron.nl>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 13 May 2003 20:11:04 +0200
In-Reply-To: <b9rbce$p0u$1@news.cistron.nl>
Message-ID: <shsisseogxz.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: Please contact postmaster@uio.no for more information
X-UiO-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Miquel van Smoorenburg <miquels@cistron-office.nl> writes:

     > Trond Myklebust  <trond.myklebust@fys.uio.no> wrote:
    >> [NFS] any more?

     > NFSv3 O_EXCL support in the client ?

I'm working on it. Consider it bundled in the long rant that Andrew
quoted concerning an atomic "open()". By allowing filesystems to
replace most of what is currently contained in open_namei() (and doing
it atomically instead of relying on local semaphores for atomicity)
it will be possible to implement O_EXCL (and to do it efficiently)...

Cheers,
  Trond
