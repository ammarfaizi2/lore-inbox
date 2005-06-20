Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbVFTVtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVFTVtJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 17:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVFTVsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 17:48:35 -0400
Received: from build.arklinux.osuosl.org ([140.211.166.26]:18872 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S261598AbVFTVlP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:41:15 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
Organization: Ark Linux team
To: dipankar@in.ibm.com
Subject: Re: 2.6.12-mm1 (kernel BUG at fs/open.c:935!)
Date: Mon, 20 Jun 2005 23:41:18 +0200
User-Agent: KMail/1.8.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, jan malstrom <xanon@snacksy.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <42B6BEC2.405@snacksy.com> <200506202318.37930.rjw@sisk.pl> <20050620212217.GD4562@in.ibm.com>
In-Reply-To: <20050620212217.GD4562@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506202341.19426.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 June 2005 23:22, Dipankar Sarma wrote:
> > > > Jun 20 14:38:07 hades kernel: kernel BUG at fs/open.c:935!
>
> Does it always happen with kded and always on reiser4 or does it happen
> with other FS ? I tested with Jan's .config and couldn't reproduce it
> in my P4 box. What exactly are you running in your machine ?

I'm seeing the same thing on a P4 box with ext3, so it's probably not 
filesystem related.

I'm using gcc 3.4.4, binutils 2.16.90.0.3 - maybe it's yet another <kernel 
developer>gcc bug</kernel developer><gcc developer>piece of crappy code in 
the kernel that should never have worked with another version</gcc 
developer> ;)
