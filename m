Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbUA0Fxf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 00:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbUA0Fxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 00:53:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:36736 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262540AbUA0Fwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 00:52:47 -0500
Date: Mon, 26 Jan 2004 21:50:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric <eric@cisu.net>
Cc: stoffel@lucent.com, ak@muc.de, Valdis.Kletnieks@vt.edu, bunk@fs.tum.de,
       cova@ferrara.linux.it, linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
Message-Id: <20040126215056.4e891086.akpm@osdl.org>
In-Reply-To: <200401262343.35633.eric@cisu.net>
References: <200401232253.08552.eric@cisu.net>
	<200401261326.09903.eric@cisu.net>
	<20040126115614.351393f2.akpm@osdl.org>
	<200401262343.35633.eric@cisu.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric <eric@cisu.net> wrote:
>
> YES. I finally have a working 2.6.2-rc1-mm3 booted kernel.
>  Lets review folks---
>  	reverted -funit-at-a-time
>  	patched test_wp_bit so exception tables are sorted sooner
>  	reverted md-partition patch

The latter two are understood, but the `-funit-at-a-time' problem is not.

Can you plesae confirm that restoring only -funit-at-a-time again produces
a crashy kernel?  And that you are using a flavour of gcc-3.3?  If so, I
guess we'll need to only enable it for gcc-3.4 and later.


