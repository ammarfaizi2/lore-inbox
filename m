Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbTDUTKR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 15:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbTDUTKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 15:10:17 -0400
Received: from pat.uio.no ([129.240.130.16]:25768 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261928AbTDUTKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 15:10:15 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16036.17639.765911.843996@charged.uio.no>
Date: Mon, 21 Apr 2003 21:22:15 +0200
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.5.68: NFS hang on write/close
In-Reply-To: <20030421164944.A7100@flint.arm.linux.org.uk>
References: <20030421164944.A7100@flint.arm.linux.org.uk>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Russell King <rmk@arm.linux.org.uk> writes:

     > 16:43:52.101873 assabet.61450 > flint.nfs: 128 getattr fh
     > 0,0/117442816 (DF) 16:43:52.102275 flint.nfs > assabet.61450:
     > reply ok 96 (DF) 16:43:52.103546 assabet.61451 > flint.nfs: 128
     > getattr fh 148,125/117442816 (DF) 16:43:52.105570 flint.nfs >
     > assabet.61451: reply ok 96 (DF) 16:44:00.446444 assabet.61452 >
     > flint.nfs: 128 getattr fh 138,158/117442816 (DF)
     > 16:44:00.446868 flint.nfs > assabet.61452: reply ok 96 (DF)
     > 16:44:03.040634 assabet.61453 > flint.nfs: 128 getattr fh
     > 138,159/117442816 (DF) 16:44:03.041039 flint.nfs >
     > assabet.61453: reply ok 96 (DF) 16:44:03.042908 assabet.61454 >
     > flint.nfs: 160 setattr fh 138,159/117442816 (DF)
     > 16:44:03.044452 flint.nfs > assabet.61454: reply ok 96 (DF)
     > <silence>

     > There don't appear to be any further NFS requests from
     > "assabet".

ARM or does it also occur on i386?

Cheers,
  Trond
