Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263886AbTKGGNQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 01:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263892AbTKGGNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 01:13:16 -0500
Received: from pat.uio.no ([129.240.130.16]:36751 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263886AbTKGGNP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 01:13:15 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16299.14326.407197.204384@charged.uio.no>
Date: Fri, 7 Nov 2003 01:13:10 -0500
To: Kris Kennaway <kris@obsecurity.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS Locking violates protocol spec (incompatible with FreeBSD)
In-Reply-To: <20031107045346.GA4583@rot13.obsecurity.org>
References: <20031107041051.GA4065@rot13.obsecurity.org>
	<shsk76c3hvr.fsf@charged.uio.no>
	<20031107045346.GA4583@rot13.obsecurity.org>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Kris Kennaway <kris@obsecurity.org> writes:

     > Thanks..obviously we'd like a fix to be committed to Linux so
     > that it interoperates out of the box with FreeBSD.  What are
     > the chances of this?

For the moment I'm still waiting for confirmation that this patch does
actually fix the problem on both FreeBSD and OSX/Panther. Once that is
done, it's up to Marcelo to tell me when he wants it into 2.4.x. He
has already announce that he only wants critical bugfixes in 2.4.23,
though, so I would guess that we will have to wait for 2.4.24.

As for 2.6.x, I expect we will have to wait until the code freeze
lifts. When it does, I already have a backlog of lockd bugfixes to
port forward from 2.4.x, so it will make sense to merge it together
with that.

Then we just have to wait for the distributions to catch up ;-)

Cheers,
  Trond
