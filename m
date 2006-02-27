Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751624AbWB0S6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbWB0S6b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 13:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751691AbWB0S6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 13:58:31 -0500
Received: from rrcs-24-227-114-150.se.biz.rr.com ([24.227.114.150]:8932 "EHLO
	sleekfreak.ath.cx") by vger.kernel.org with ESMTP id S1751624AbWB0S6a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 13:58:30 -0500
Date: Mon, 27 Feb 2006 14:04:40 -0500 (EST)
From: shogunx <shogunx@sleekfreak.ath.cx>
To: Christian <christiand59@web.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Integration of clustering (mosix) into mainline
In-Reply-To: <200602271638.11147.christiand59@web.de>
Message-ID: <Pine.LNX.4.44.0602271354020.28982-100000@sleekfreak.ath.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Feb 2006, Christian wrote:

Hi Christian,

> I just wondered if there is any interest in integrating a technology like
> OpenMosix into mainline. This would make more sense than ever, especially
> with the virtualization work going on now. What objections do you feel, and
> what amount of work would it be?

I have an interest in such.  I agree that xen/openmosix is a powerful
combo, one that would give linux mainframe-like capabilities,
(i know, i know, there is linux support for s/390, in fact, I
own such a mainframe, but there is no Xen for linux/390, and
most linux/390 images run in vm's anyway) particularly
with the addition of OM for scalability.  Amount of work?  On x86, the 2.6
OM branch is (relatively) stable as a set of patches now, but the entire
suite is not finished yet.  The kernel code is functional, though, being
massaged, something that would no doubt be better off with the help of
mainline kernel developers.  As of yet there are no userspace apps, such
as an automigration daemon, that are necessary to have a fuctional OM
cluster that actually migrates processes.  The biggest hurdle I see to
inclusion in the mainline kernel is the support for previously
non-supported architectures... though I would love to add my alphaservers
to my OM cluster:)  Once again, these ports could probably be lubricated
with the help of mainline kernel developers with specific knowledge and
experience on these platforms.

I hope that helps,
Scott


>
> Just curious...
>
> -Christian
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

sleekfreak pirate broadcast
http://sleekfreak.ath.cx:81/

