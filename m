Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbTIPRDQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 13:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbTIPRDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 13:03:15 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:5394 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261953AbTIPRDO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 13:03:14 -0400
Date: Tue, 16 Sep 2003 12:53:57 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Timothy Miller <miller@techsource.com>
cc: Dave Jones <davej@redhat.com>, Jamie Lokier <jamie@shareable.org>,
       richard.brunner@amd.com, alan@lxorguk.ukuu.org.uk, zwane@linuxpower.ca,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
In-Reply-To: <3F672B55.3000600@techsource.com>
Message-ID: <Pine.LNX.3.96.1030916125253.27636A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Sep 2003, Timothy Miller wrote:

> 
> 
> Bill Davidsen wrote:
> 
> > 
> > If the fixup were not in place, would it be useful to emit a warning
> > like "you have booted a non-Athlon kernel on an Athlon process, user
> > programs may get unexpected page faults." That's in init code, hopefully
> > there is no critical size issue there, I assume, other than how large a
> > kernel can be booted by the boot loader.
> > 
> 
> How many bytes would that code require?

No resident bytes, as noted it's in init and will be released at the end
of boot.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

