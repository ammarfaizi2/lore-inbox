Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbVDUQWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbVDUQWH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 12:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVDUQWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 12:22:07 -0400
Received: from ns1.coraid.com ([65.14.39.133]:39864 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S261500AbVDUQQx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 12:16:53 -0400
To: Greg KH <greg@kroah.com>
Cc: 7eggert@gmx.de, linux-kernel@vger.kernel.org
Subject: /sys/module (was Re: [PATCH 2.6.12-rc2] aoe [1/6]: improve allowed
 interfaces configuration)
References: <3VqSf-2z7-15@gated-at.bofh.it>
	<E1DOVtj-0003bF-6c@be1.7eggert.dyndns.org> <87y8bcjlpq.fsf@coraid.com>
	<20050421145658.GA27263@kroah.com> <87pswoi1vl.fsf@coraid.com>
	<20050421160104.GA10221@kroah.com>
From: Ed L Cashin <ecashin@coraid.com>
Date: Thu, 21 Apr 2005 12:11:39 -0400
In-Reply-To: <20050421160104.GA10221@kroah.com> (Greg KH's message of "Thu,
 21 Apr 2005 09:01:04 -0700")
Message-ID: <87u0m0f6tg.fsf_-_@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

...
> It's not for things other than modules, it's filling a real need that
> you yourself just pointed out.  Namely, we need to be able to have
> access to module paramaters in a consistant place, no matter if the
> driver is built into the kernel or not.
>
> Man, you try to be nice to people...  :)

It wasn't a complaint --- like I said, I'm pleased!  I just wanted to
serve as a datum: one guy was surprised.

I wanted to put the interfaces list configuration into sysfs, but I
didn't really know how or where to put it, so I procrastinated.  Then
I created the module parameter and was pleased to see it show up in
sysfs.  I had read about module parameters before, but I had forgotten
about that feature, or maybe it's newer than the docs I read.

Thanks for working so hard to make sysfs useful.

-- 
  Ed L Cashin <ecashin@coraid.com>

