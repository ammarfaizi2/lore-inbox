Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264953AbTLRGl4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 01:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264954AbTLRGl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 01:41:56 -0500
Received: from pat.uio.no ([129.240.130.16]:54948 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264953AbTLRGlz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 01:41:55 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16353.19501.912739.814677@guts.uio.no>
Date: Thu, 18 Dec 2003 01:41:49 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.0
In-Reply-To: <20031217221432.4e1bbd60.akpm@osdl.org>
References: <Pine.LNX.4.58.0312171951030.5789@home.osdl.org>
	<20031217211516.2c578bab.akpm@osdl.org>
	<shsekv2ptcb.fsf@guts.uio.no>
	<20031217221432.4e1bbd60.akpm@osdl.org>
X-Mailer: VM 7.07 under 21.4 (patch 12) "Portable Code" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.9, required 12,
	BAYES_00 -4.90)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andrew Morton <akpm@osdl.org> writes:

     > I doubt that people will be critially dependent on NFS4 client
     > functionality in 2.6 for a while, and your changes will only
     > affect NFS4, so go wild.

     > If the change was more intrusive then it would be better to
     > maintain+develop it in -mm until we've all happy, then merge it
     > across.

Thanks... There are some fairly major changes to the NFS attribute
revalidation that I'm working on right now, and that will be likely to
come in the second category (as they affect NFSv2/v3 and v4). They
promise some definite caching wins, though, so I'll try to push them
into 'mm' as soon as I'm satisfied with their stability...

All the rest of the patches should come in the first category, though
I'll make sure that I label any NFSv2/v3 changes clearly FYI.

Cheers,
  Trond
