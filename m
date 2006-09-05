Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161055AbWIEUd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161055AbWIEUd1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 16:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161054AbWIEUd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 16:33:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33246 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161052AbWIEUdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 16:33:25 -0400
Date: Tue, 5 Sep 2006 13:33:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Miles Lane <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       linux1394-devel@lists.sourceforge.net
Subject: Re: 2.6.18-rc5-mm1 + all hotfixes -- INFO: possible recursive
 locking detected
Message-Id: <20060905133311.fd8d1ff7.akpm@osdl.org>
In-Reply-To: <44FDDBE7.1040906@s5r6.in-berlin.de>
References: <a44ae5cd0609051037k47d1ad7dsa8276dc0cec416bf@mail.gmail.com>
	<20060905111306.80398394.akpm@osdl.org>
	<a44ae5cd0609051249y767eed58ja1fe1b27858f5cd@mail.gmail.com>
	<44FDDBE7.1040906@s5r6.in-berlin.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Sep 2006 22:19:51 +0200
Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:

> One tool to make this a little bit easier is quilt. This should be
> available as a package for most distributions. I haven't tried it myself
> yet, but akpm's "broken-out" patch distribution can be manipulated by
> quilt.

Each -mm announcement contains the following text:

:- If you hit a bug in -mm and it is not obvious which patch caused it, it is
:  most valuable if you can perform a bisection search to identify which patch
:  introduced the bug.  Instructions for this process are at
:
:        http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt
:
:  But beware that this process takes some time (around ten rebuilds and
:  reboots), so consider reporting the bug first and if we cannot immediately
:  identify the faulty patch, then perform the bisection search.
:

;)
