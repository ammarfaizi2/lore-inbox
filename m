Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbTEDSs3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 14:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbTEDSs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 14:48:29 -0400
Received: from pat.uio.no ([129.240.130.16]:56015 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261561AbTEDSs2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 14:48:28 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16053.25445.434038.90945@charged.uio.no>
Date: Sun, 4 May 2003 21:00:53 +0200
To: Christoph Hellwig <hch@lst.de>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove useless MOD_{INC,DEC}_USE_COUNT from sunrpc
In-Reply-To: <20030504205306.A11647@lst.de>
References: <20030504191447.C10659@lst.de>
	<16053.20430.903508.188812@charged.uio.no>
	<20030504203655.A11574@lst.de>
	<16053.24599.277205.64363@charged.uio.no>
	<20030504205306.A11647@lst.de>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Christoph Hellwig <hch@lst.de> writes:

     > Previously you incremented the usecount and now we're waiting
     > for the thread to finish in module_exit().

Fair enough...

Cheers,
  Trond
