Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264671AbTFENjF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 09:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264672AbTFENjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 09:39:05 -0400
Received: from pat.uio.no ([129.240.130.16]:15247 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264671AbTFENjE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 09:39:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16095.19179.63291.595768@charged.uio.no>
Date: Thu, 5 Jun 2003 15:51:39 +0200
To: Russell King <rmk@arm.linux.org.uk>
Cc: Adrian Cox <adrian@humboldt.co.uk>, Frank Cusack <fcusack@fcusack.com>,
       linux-kernel@vger.kernel.org
Subject: Re: nfs_refresh_inode: inode number mismatch
In-Reply-To: <20030605101351.C960@flint.arm.linux.org.uk>
References: <20030603165438.A24791@google.com>
	<shswug2sz5x.fsf@charged.uio.no>
	<20030604142047.C24603@google.com>
	<20030605101120.2bea125a.adrian@humboldt.co.uk>
	<20030605101351.C960@flint.arm.linux.org.uk>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have ques\tions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Russell King <rmk@arm.linux.org.uk> writes:

     > If this is the case, you need to ensure that you don't reboot
     > the client before the servers XID cache times out the XID
     > numbers.  For Linux knfsd, that's around 2 minutes.

Note that older versions of knfsd didn't time out their replay cache
at all...

Cheers,
  Trond
