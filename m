Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVBVVis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVBVVis (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 16:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVBVVir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 16:38:47 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:49640 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S261256AbVBVVin
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 16:38:43 -0500
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Matthew Wilcox <matthew@wil.cx>,
       linux-ia64@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch -mm series] ia64 specific /dev/mem handlers
References: <16923.193.128608.607599@jaguar.mkp.net>
	<20050222020309.4289504c.akpm@osdl.org>
	<yq0ekf8lksf.fsf@jaguar.mkp.net>
	<20050222175225.GK28741@parcelfarce.linux.theplanet.co.uk>
	<20050222112513.4162860d.akpm@osdl.org>
	<1109100938.25666.44.camel@localhost>
From: Jes Sorensen <jes@wildopensource.com>
Date: 22 Feb 2005 16:38:42 -0500
In-Reply-To: <1109100938.25666.44.camel@localhost>
Message-ID: <yq0650kl1gd.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Dave" == Dave Hansen <haveblue@us.ibm.com> writes:

Dave> I was talking with Nigel Cunningham about doing something a
Dave> little different from the classic page flag bits when the number
Dave> of users is restricted and performance isn't ultra-critical.
Dave> Would something like this work for you, instead of using a real
Dave> page->flags bit for PG_cached?

Just took a quick look at this and it looks a bit heavy for our
use. We are only looking at a small number of pages. However I could
imagine future cases where performance may be more critical.

Cheers,
Jes
