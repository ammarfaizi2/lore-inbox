Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264658AbUD1Gq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264658AbUD1Gq6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 02:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264660AbUD1Gq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 02:46:58 -0400
Received: from gollum.snap.net.nz ([202.37.101.26]:63366 "EHLO
	gollum.snap.net.nz") by vger.kernel.org with ESMTP id S264658AbUD1Gq5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 02:46:57 -0400
Date: Wed, 28 Apr 2004 18:51:45 +1200 (NZST)
From: Keith Duthie <psycho@albatross.co.nz>
To: Karim Yaghmour <karim@opersys.com>
cc: ncunningham@linuxmail.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What does tainting actually mean?
In-Reply-To: <408F4658.9050109@opersys.com>
Message-ID: <Pine.LNX.4.53.0404281846370.21340@loki.albatross.co.nz>
References: <opr65eq9ncshwjtr@laptop-linux.wpcb.org.au> <408F4658.9050109@opersys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2004, Karim Yaghmour wrote:

> The legal/moral implications of taint/binary-mods/etc. aside, I think it
> may be worth putting some thought into coming up with a way to identify
> which patches were applied to a kernel -- given the wide-spread use of this
> method to add/remove/amend kernel functionality. Maybe there should be a
> /proc/sys/kernel/patches file at runtime which would provide a list of
> applied patches and some characteristics/description? When patches are

Or maybe we could add a line to the top level Makefile to append something
to the version number to indicate things like whether a kernel is a
prerelease and whether/which extra patches have been added.

We could call it something like "EXTRAVERSION"...

-- 
Just because it isn't nice doesn't make it any less a miracle.
     http://users.albatross.co.nz/~psycho/     O-   -><-
