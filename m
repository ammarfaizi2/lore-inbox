Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263181AbTJZPFt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 10:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbTJZPFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 10:05:49 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:44223 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263181AbTJZPFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 10:05:47 -0500
Date: Sun, 26 Oct 2003 16:05:45 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.4 <-> 2.6 compatibility (was: Linux 2.6.0-test9)
Message-ID: <20031026150544.GJ15838@merlin.emma.line.org>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0310251152410.5764-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310251152410.5764-100000@home.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Oct 2003, Linus Torvalds wrote:

> In other words, even if you think that something is the most important
> piece of software in the world, if you can't make aunt Tilly up the street
> say "oh, but that would be a show-stopper", then don't bother sending it 
> to me.
> 
> If it corrupts data, is a security issue, or causes lockups or just basic
> nonworkingness: and this happens on hardware that _normal_ people are
> expected to have, then it's critical.  Otherwise, it's noise and should
> wait.
> 
> If this works out, then I'll submit -test10 to Andrew Morton, and if he 
> takes it we'll probably have a real 2.6.0 after a final shakedown. So try 
> to help, please. We'll all be happier.

A favor that I'd ask of the Linux kernel gurus is:

As 2.6 starts stabilizing, PLEASE try to synch up major components of
2.6 and 2.4 so that the same user space can be used for either version.
It's fine with modutils and stuff, but when it comes to LVM, these 2.4
and 2.6 versions are a problem. 2.4 doesn't have Device Mapper in
baseline, and getting DM and XFS in is sorta hard. (ACPI seems to be in
better shape now.)

To enlarge the testing base, it would be good if people could just drop
a 2.6 kernel, some user-space updates and then dual-boot 2.4 and 2.6
hassle free at will without worrying about a dozen 2.4 kernel patches to
make it compatible with the new user space.

(I may have missed a 2.4 spinoff that does just that, merge DM and XFS
and ACPI and other updates so it can coexist with a 2.6-user space.)
