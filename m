Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268164AbUGWXFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268164AbUGWXFq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 19:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268166AbUGWXFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 19:05:46 -0400
Received: from 209-128-98-078.BAYAREA.NET ([209.128.98.78]:26010 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S268164AbUGWXFo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 19:05:44 -0400
Message-ID: <32791.66.11.168.47.1090623872.squirrel@www.zytor.com>
In-Reply-To: <20040723214055.GR19329@fs.tum.de>
References: <40FFD760.8060504@unix.eng.ua.edu>
    <cdpee5$otu$1@gatekeeper.tmr.com> <cdr5i3$568$1@terminus.zytor.com>
    <20040723214055.GR19329@fs.tum.de>
Date: Fri, 23 Jul 2004 16:04:32 -0700 (PDT)
Subject: Re: A users thoughts on the new dev. model
From: hpa@zytor.com
To: "Adrian Bunk" <bunk@fs.tum.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> One problem from a user's point of view is that removal of obsolete code
> that works sufficiently for some users.
>
> Andrew said explicitely in a mail to linux-kernel that he'd consider
> removing devfs "mid-2005" - and it didn't sound as if this would only be
> a -mm "feature".
>
> Even if 2.7 is started this doesn't has to imply that it has to be
> flooded with big changes - a short 2.7 with relativley few invasive
> changes might also be an option.
>

There is no difference from a user's point of view between a "short 2.7"
and "a close -mm tree."  Either way devfs is on death row, because it's
buggy and unmaintained.  Any piece of code, *especially* one as invasive
as devfs, which is buggy and unmaintained is a hassle to for *all* kernel
development, and have to be extricated at some point.

	-hpa

