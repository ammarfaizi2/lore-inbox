Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264060AbTF0Hao (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 03:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264027AbTF0Hao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 03:30:44 -0400
Received: from pat.uio.no ([129.240.130.16]:40103 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264060AbTF0Ham (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 03:30:42 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16123.62958.575097.541892@charged.uio.no>
Date: Fri, 27 Jun 2003 09:44:46 +0200
To: Sven Geggus <sven@gegg.us>
Cc: linux-kernel@vger.kernel.org
Subject: PROBLEM: reproduceable 2.4.21 NFS client Freeze
In-Reply-To: <20030625080549.GA26849@benzin.geggus.net>
References: <20030624101227.GA21744@benzin.geggus.net>
	<shsptl3tie2.fsf@charged.uio.no>
	<20030625080549.GA26849@benzin.geggus.net>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm... 2 questions for you:

 Does this problem occur with any other servers than the Hummingbird?

 Could you try to capture the XDR output as well? Try using
      "echo 35 >/proc/sys/sunrpc/nfs_debug"

Cheers,
  Trond
