Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVBHCUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVBHCUm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 21:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbVBHCUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 21:20:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:43142 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261386AbVBHCUi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 21:20:38 -0500
Date: Mon, 7 Feb 2005 18:20:36 -0800
From: Chris Wright <chrisw@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: David Wagner <daw-usenet@taverner.cs.berkeley.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BSD Secure Levels: claim block dev in file struct rather than inode struct, 2.6.11-rc2-mm1 (3/8)
Message-ID: <20050207182035.D469@build.pdx.osdl.net>
References: <20050207192108.GA776@halcrow.us> <20050207193129.GB834@halcrow.us> <20050207142603.A469@build.pdx.osdl.net> <200502072241.j17MfTfP027969@turing-police.cc.vt.edu> <cu95po$3ch$1@abraham.cs.berkeley.edu> <200502080210.j182Aioh007619@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200502080210.j182Aioh007619@turing-police.cc.vt.edu>; from Valdis.Kletnieks@vt.edu on Mon, Feb 07, 2005 at 09:10:44PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Valdis.Kletnieks@vt.edu (Valdis.Kletnieks@vt.edu) wrote:
> open("/tmp/sh-thd-1107848098", O_WRONLY|O_CREAT|O_TRUNC|O_EXCL|O_LARGEFILE, 0600) = 3

O_EXCL

> Wow - if my /tmp was on the same partition, and I'd hard-linked that
> file to /etc/passwd, it would be toast now if root had run it.

So, in fact, it wouldn't ;-)

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
