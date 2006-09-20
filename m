Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751565AbWITOgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbWITOgb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 10:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751569AbWITOgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 10:36:31 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:53365 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751564AbWITOga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 10:36:30 -0400
Date: Wed, 20 Sep 2006 21:39:27 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: Don Mullis <dwm@meer.net>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, akpm@osdl.org,
       Valdis.Kletnieks@vt.edu
Subject: Re: [patch 8/8] stacktrace filtering for fault-injection capabilities
Message-ID: <20060920133927.GA4030@miraclelinux.com>
References: <20060914102012.251231177@localhost.localdomain> <20060914102033.462112306@localhost.localdomain> <1158645471.2419.13.camel@localhost.localdomain> <20060919090945.GE24271@miraclelinux.com> <1158687327.2509.13.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158687327.2509.13.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2006 at 10:35:27AM -0700, Don Mullis wrote:
> There's no problem with hiding per se, but rather with the indentation
> level.  It's most natural for the user to have dependent options
> indented under their "parent".  For an example, in "menuconfig" try
> setting "Compile the kernel with frame unwind information";
> notice that "Stack unwind support" appears immediately underneath
> it, indented.  The indentation reminds the user why "Stack unwind
> support" has appeared.
> 

I see.

> Note that several of the pre-existing, non-fault-injection options
> under "Kernel debugging", are also broken in this way.

Perhaps you can move UNWIND_INFO, STACK_UNWIND, and DEBUG_FS
entries ealier in the list. It improves improve appearance for
other DEBUG_KERNEL dependent config options like (DEBUG_VM,
FRAME_POINTER, ...).

