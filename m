Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265065AbTFCPzh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 11:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265069AbTFCPzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 11:55:37 -0400
Received: from pat.uio.no ([129.240.130.16]:10196 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S265065AbTFCPzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 11:55:35 -0400
To: Edward Hibbert <EH@dataconnection.com>
Cc: "'Vivek Goyal'" <vivek.goyal@wipro.com>, trond.myklebust@fys.uio.no,
       Ion Badulescu <ionut@badula.org>, viro@math.psu.edu, davem@redhat.com,
       ezk@cs.sunysb.edu, indou.takao@jp.fujitsu.com,
       nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [NFS] Disabling Symbolic Link Content Caching in NFS Client
References: <CFCD2C778CF1D611B5B400065B04D5C84A736F@KENTON>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 03 Jun 2003 18:08:35 +0200
In-Reply-To: <CFCD2C778CF1D611B5B400065B04D5C84A736F@KENTON>
Message-ID: <shsbrxfp2ik.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have ques\tions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Edward Hibbert <EH@dataconnection.com> writes:

     > Our application consists of a number of machines collaborating
     > on a shared database over NFS.  We therefore require the
     > ability to force data to be sync'd from the client to the
     > backend - and at the moment we do this by disabling caching
     > completely, via the noac option and acquiring and releasing
     > non-exclusive locks round io calls.

What does this have to do with symlinks?

...and why can't you use DIRECTIO? The above sort of application is
exactly what it is being introduced for.

Cheers,
  Trond
