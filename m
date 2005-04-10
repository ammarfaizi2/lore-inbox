Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVDJCVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVDJCVA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 22:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVDJCVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 22:21:00 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:39566 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261239AbVDJCUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 22:20:55 -0400
Date: Sat, 9 Apr 2005 19:20:45 -0700
From: Paul Jackson <pj@engr.sgi.com>
To: Paul Jackson <pj@engr.sgi.com>
Cc: torvalds@osdl.org, pasky@ucw.cz, rddunlap@osdl.org, ross@jose.lug.udel.edu,
       linux-kernel@vger.kernel.org
Subject: Re: more git updates..
Message-Id: <20050409192045.2bf3c855.pj@engr.sgi.com>
In-Reply-To: <20050409190715.679e9023.pj@engr.sgi.com>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
	<20050409200709.GC3451@pasky.ji.cz>
	<Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
	<20050409190715.679e9023.pj@engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From before:

The sha1 (ascii) digests for 16817 files take:

	689497 bytes before compression
	397475 bytes after minigzip

New numbers:

The sha1 (binary) digests for 16817 files take:

	336340 bytes before compression
	334943 bytes after minigzip

So compressing binary digests isn't worth a darn, and compressing ascii
digests gets them down to within 18% of binary digests in size.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
