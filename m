Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262012AbULHCOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbULHCOT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 21:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbULHCLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 21:11:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:34788 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262009AbULHCJA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 21:09:00 -0500
Date: Tue, 7 Dec 2004 18:08:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: andrea@suse.de, nickpiggin@yahoo.com.au, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: Time sliced CFQ io scheduler
Message-Id: <20041207180844.0fa92601.akpm@osdl.org>
In-Reply-To: <20041207180033.6699425b.akpm@osdl.org>
References: <20041202130457.GC10458@suse.de>
	<20041202134801.GE10458@suse.de>
	<20041202114836.6b2e8d3f.akpm@osdl.org>
	<20041202195232.GA26695@suse.de>
	<20041208003736.GD16322@dualathlon.random>
	<1102467253.8095.10.camel@npiggin-nld.site>
	<20041208013732.GF16322@dualathlon.random>
	<20041207180033.6699425b.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> If a distro is
>  always selecting CFQ then they've probably gone and deoptimised all their
>  IDE users.  

That being said, yeah, once we get the time-sliced-CFQ happening, it should
probably be made the default, at least until AS gets fixed up.  We need to
run the numbers and settle on that.

