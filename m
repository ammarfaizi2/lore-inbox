Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbTEMQAU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 12:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbTEMQAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 12:00:17 -0400
Received: from pat.uio.no ([129.240.130.16]:6127 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261864AbTEMP7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 11:59:08 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16065.6462.15209.428226@charged.uio.no>
Date: Tue, 13 May 2003 18:11:42 +0200
To: Daniel Jacobowitz <dan@debian.org>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6 must-fix list, v2
In-Reply-To: <20030513155901.GA26116@nevyn.them.org>
References: <20030512155417.67a9fdec.akpm@digeo.com>
	<20030512155511.21fb1652.akpm@digeo.com>
	<shswugvjcy9.fsf@charged.uio.no>
	<20030513155901.GA26116@nevyn.them.org>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: Please contact postmaster@uio.no for more information
X-UiO-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Daniel Jacobowitz <dan@debian.org> writes:

     > Well, using BK as of Friday last week I'm still having a
     > complete disaster of NFS support.

Please try a more recent snapshot. The OOM situation was only fixed
with the patches that Linus pulled for patch-2.5.69-bk7
(i.e. yesterday's snapshot).

Oh. Please also turn off any 'soft' mount option that you may
have. Like it or not, those *will* cause EIO errors.

Cheers,
 Trond
