Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265064AbTFCPxK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 11:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265065AbTFCPxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 11:53:10 -0400
Received: from pat.uio.no ([129.240.130.16]:53713 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S265064AbTFCPwM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 11:52:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16092.50997.483311.566882@charged.uio.no>
Date: Tue, 3 Jun 2003 18:05:09 +0200
To: "Vivek Goyal" <vivek.goyal@wipro.com>
Cc: "Ion Badulescu" <ionut@badula.org>, <viro@math.psu.edu>,
       <davem@redhat.com>, <ezk@cs.sunysb.edu>, <indou.takao@jp.fujitsu.com>,
       <nfs@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: RE: [NFS] Disabling Symbolic Link Content Caching in NFS Client
In-Reply-To: <2BB7146B38D9CA40B215AB3DAAE24C080BA622@blr-m2-msg.wipro.com>
References: <2BB7146B38D9CA40B215AB3DAAE24C080BA622@blr-m2-msg.wipro.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have ques\tions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Vivek Goyal <vivek.goyal@wipro.com> writes:

     > You are right. But our idea is to provide an option to
     > disable/enable caching based on the nature of intended
     > application.

Apart from hlfsd, which applications actually depend on symlinks not
being cached?

     > With this, Linux will have enhanced flexibility in NFS client
     > like other operating systems. For example.

Again: Do you have any concrete examples of programs that need this
functionality, and that cannot be replaced?

Cheers,
  Trond
