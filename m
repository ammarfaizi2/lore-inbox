Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbTLIKZe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 05:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbTLIKZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 05:25:34 -0500
Received: from main.gmane.org ([80.91.224.249]:62425 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262041AbTLIKZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 05:25:29 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
Date: Tue, 09 Dec 2003 11:25:26 +0100
Message-ID: <yw1x4qwai8yx.fsf@kth.se>
References: <200312081536.26022.andrew@walrond.org> <20031208154256.GV19856@holomorphy.com>
 <3FD4CC7B.8050107@nishanet.com> <20031208233755.GC31370@kroah.com>
 <20031209061728.28bfaf0f.witukind@nsbm.kicks-ass.org>
 <3FD577E7.9040809@nishanet.com>
 <pan.2003.12.09.09.46.27.327988@dungeon.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:4c1NCZxVv6nzlzhLA42n9JtmYog=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Jellinghaus <aj@dungeon.inka.de> writes:

> maybe add this to the faq?
>
> Q: devfs did load drivers when someone tried to open() a non existing
> device. will sysfs/hotplug/udev do this?
>
> A: there is no need to.

I never like it when the answer is "you don't want to do this".  It
makes me think of a certain Redmond based company.

> hotplug/sysfs/udev will create devices for all hardware supported by
> the kernel and the available modules. it will do that during boot
> up, and whenever new hardware is added. so you can expect all
> devices be already present, no need for a devfs like mechanism.

-- 
Måns Rullgård
mru@kth.se

