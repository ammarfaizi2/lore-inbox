Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbVCCK02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbVCCK02 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 05:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262404AbVCCK02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 05:26:28 -0500
Received: from scrat.hensema.net ([62.212.82.150]:10636 "EHLO
	scrat.hensema.net") by vger.kernel.org with ESMTP id S262329AbVCCK0Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 05:26:25 -0500
From: Erik Hensema <erik@hensema.net>
Subject: Re: RFD: Kernel release numbering
Date: Thu, 3 Mar 2005 10:26:24 +0000 (UTC)
Message-ID: <slrnd2dpig.icg.erik@bender.home.hensema.net>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com> <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002733.GH10124@redhat.com> <42268037.3040300@osdl.org>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.8.0 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap (rddunlap@osdl.org) wrote:
> Maybe I don't understand?  Is someone expecting distro
> quality/stability from kernel.org kernels?
> I don't, but maybe I'm one of those minorities.

There are few distributors who can sufficiently QA the kernel
they ship. I think only Redhat/Fedora, Novell/Suse and
Mandrake/Conectiva currently have *good* testing procedures and
good QA. Most other distributions basically ship the vanilla
Linus kernel (or Alan kernel) with some basic patches applied.

Besides that, a *lot* of admins still prefer to compile their own
kernel. I often encounter admins who still don't know about the
2.6 development scheme and blindly compile each shiny new 2.6
kernel released by Linus.

So basically what I'm trying to tell is: it could be time to
start the 2.7 series to have some room for experimentation. That
is what Linus enjoys doing (*) and that is what Linus is good at.
Leave the 2.6 kernel to Alan or someone else.

However, I think a 2.6.x-mm kernel is still a good idea after 2.7
branches. The -mm kernel could be a collection of backports from
the 2.7 kernel, waiting to be included in the 2.6 kernel.

The 3.x.y kernel could be the place for very wild
experimentation. I'd love to see a kernel which supports a
object-relational non-POSIX compatible filesystem, ready for
2010's storage requirements. But that's just me.

(*) I've got a magic Linus brain reader device.
-- 
Erik Hensema <erik@hensema.net>
