Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750924AbVHXC54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbVHXC54 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 22:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbVHXC54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 22:57:56 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:55701 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP
	id S1750710AbVHXC54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 22:57:56 -0400
X-ORBL: [67.124.117.85]
Date: Tue, 23 Aug 2005 19:57:40 -0700
From: Chris Wedgwood <cw@f00f.org>
To: robotti@godmail.com
Cc: linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: Initramfs and TMPFS!
Message-ID: <20050824025740.GA3361@taniwha.stupidest.org>
References: <200508232205.j7NM5l1g018046@ms-smtp-01.rdc-nyc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508232205.j7NM5l1g018046@ms-smtp-01.rdc-nyc.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2005 at 06:05:47PM -0400, robotti@godmail.com wrote:

> I was just making a suggestion to whoever it may concern, because I
> think it would extend the usefullness of initramfs.

I have a path for initramfs to use tmpfs.  It's sorta hacky so I never
submitted it and solves a niche problem for embedded people.

Ultimately we might one day still want to change how we initialize the
early userspace (Al suggesting a reasomably nice way to move the
decompressor(s) to userspace for example) so I don't feel there is a
compelling reason to do more than cleanups in this area right now.

