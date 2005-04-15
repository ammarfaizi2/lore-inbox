Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262327AbVDOXgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbVDOXgj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 19:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbVDOXgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 19:36:35 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:17338 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S262327AbVDOXge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 19:36:34 -0400
From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: Re: [SATA] status reports updated
To: 7eggert@gmx.de, Tomasz Chmielewski <mangoo@interia.pl>,
       Andre Tomt <andre@tomt.net>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Sat, 16 Apr 2005 01:36:05 +0200
References: <3THXg-6HX-5@gated-at.bofh.it> <3THXg-6HX-7@gated-at.bofh.it> <3THXg-6HX-9@gated-at.bofh.it> <3THXg-6HX-11@gated-at.bofh.it> <3THXg-6HX-3@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1DMaM1-0001WQ-C6@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org> wrote:
> Tomasz Chmielewski <mangoo@interia.pl> wrote:

>> Is there a way to check what firmware a drive has
> 
> The obvious one: hdparm

<Ingrid>
Or, since hdparm doesn't work for SCSI devices,
cat /sys/block/sd$n/device/rev

(might depend on the vendor)
-- 
Funny quotes:
21. Support bacteria - they're the only culture some people have.

Friﬂ, Spammer: admin@outplay986biz.us 4FMe@vDkmGd.7eggert.dyndns.org
