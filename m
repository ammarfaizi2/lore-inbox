Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbTKCVJY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 16:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263386AbTKCVI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 16:08:56 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:7086 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S263365AbTKCVIx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 16:08:53 -0500
Date: Mon, 3 Nov 2003 22:00:06 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: how to restart userland?
Message-ID: <20031103220006.A21093@electric-eye.fr.zoreil.com>
References: <20031103193940.GA16820@louise.pinerecords.com> <Pine.LNX.4.53.0311031519050.2654@chaos> <20031103204118.GJ16820@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031103204118.GJ16820@louise.pinerecords.com>; from szepe@pinerecords.com on Mon, Nov 03, 2003 at 09:41:18PM +0100
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Szepe <szepe@pinerecords.com> :
[...]
> OK, that sounds like a plan.  There's one problem, though -- I really need
> to do this in a single step (i.e. I won't have console access to issue any
> commands after all processes have been killed off and all the world's got
> is a root shell), so the script mustn't get killed while the system is coming
> down.

Hack sysvinit/shutdown.c so that it exec /sbin/telinit U and put the adequate
command in /etc/inittab ?

--
Ueimor
