Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbTEMPed (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 11:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbTEMPed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 11:34:33 -0400
Received: from pat.uio.no ([129.240.130.16]:51169 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261428AbTEMPec (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 11:34:32 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 must-fix list, v2
References: <20030512155417.67a9fdec.akpm@digeo.com>
	<20030512155511.21fb1652.akpm@digeo.com>
	<1052834227.432.30.camel@dhcp22.swansea.linux.org.uk>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 13 May 2003 17:47:10 +0200
In-Reply-To: <1052834227.432.30.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <shsy91aonlt.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: Please contact postmaster@uio.no for more information
X-UiO-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

     > Lots of recent 2.4 NFS fixes in the client especially want
     > forward porting

Which ones are you thinking about in particular? I've developed most
of those fixes in parallel on 2.4.x and 2.5.x, and have tried to push
them to Linus asap. I therefore believe 2.5.x should be pretty much up
to date.
I believe Chuck has compiled a list of discrepancies, but IIRC there
are no showstoppers there.

The most serious non-NFSv4 problem I believe is the fact that IODirect
for NFS needs to be completed. I need to bug Chuck about that.

I also need to look over the VFS file locking changes to see if
anything has broken lockd.

any more?

Cheers,
  Trond
