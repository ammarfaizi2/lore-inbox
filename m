Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263515AbTDGPFp (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 11:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263517AbTDGPFo (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 11:05:44 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:64264
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S263515AbTDGPFn 
	(for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 11:05:43 -0400
Subject: Re: 2.5: NFS troubles
From: Robert Love <rml@tech9.net>
To: trond.myklebust@fys.uio.no
Cc: Siim Vahtre <siim@pld.ttu.ee>, linux-kernel@vger.kernel.org,
       NFS maillist <nfs@lists.sourceforge.net>
In-Reply-To: <16017.31727.798961.19493@charged.uio.no>
References: <1049630768.592.24.camel@teapot.felipe-alfaro.com>
	 <shsbrzjn5of.fsf@charged.uio.no> <20030406171855.6bd3552d.akpm@digeo.com>
	 <1049675270.753.166.camel@localhost>
	 <16017.31727.798961.19493@charged.uio.no>
Content-Type: text/plain
Organization: 
Message-Id: <1049728638.717.16.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 07 Apr 2003 11:17:19 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-07 at 09:23, Trond Myklebust wrote:

> OK. I've managed to squash the NFS read corruption problems that I had
> on my 2.5.x client setup with the following patch.
> Since the two of you reported what appears to be the same problem,
> would you mind trying it out?

This fixes it for me.  No errors, no corruption.

I did a verify of the md5sums of all of the Red Hat 9 RPM packages over
NFS.  I had random failures (in different packages each time) before.

I just did it twice to be sure -- it works.

Thank you, Trond.

	Robert Love

