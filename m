Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbTEMPTz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 11:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbTEMPTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 11:19:55 -0400
Received: from pat.uio.no ([129.240.130.16]:12505 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261411AbTEMPTw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 11:19:52 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16065.4109.129542.777460@charged.uio.no>
Date: Tue, 13 May 2003 17:32:29 +0200
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6 must-fix list, v2
In-Reply-To: <20030513152228.GA4388@suse.de>
References: <20030512155417.67a9fdec.akpm@digeo.com>
	<20030512155511.21fb1652.akpm@digeo.com>
	<shswugvjcy9.fsf@charged.uio.no>
	<20030513135756.GA676@suse.de>
	<16065.3159.768256.81302@charged.uio.no>
	<20030513152228.GA4388@suse.de>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: Please contact postmaster@uio.no for more information
X-UiO-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Dave Jones <davej@codemonkey.org.uk> writes:

     > unexporting and reexporting also works fine.  Perhaps 'kill'
     > was an over-strong word to use above, lets replace it with
     > 'make it break causing possible fs corruption'.

That is a server bug. There are no rules for congestion control
etc. in the NFS or SunRPC protocols, so the server is supposed to be
able to cope with whatever the client manages to throw at it.

I presume, though, that you are not seeing the 2.4.x NFS server die in
this way when you blast it with a 2.5 client?

Cheers,
  Trond
