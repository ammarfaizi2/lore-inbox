Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265020AbSKAOBt>; Fri, 1 Nov 2002 09:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265021AbSKAOBt>; Fri, 1 Nov 2002 09:01:49 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:7996 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S265020AbSKAOBt>; Fri, 1 Nov 2002 09:01:49 -0500
To: Pavel Machek <pavel@ucw.cz>
Cc: Dave Jones <davej@codemonkey.org.uk>, boissiere@adiglobal.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [STATUS 2.5]  October 30, 2002
References: <20021030161708.GA8321@suse.de>
	<m1iszjgmaz.fsf@frodo.biederman.org>
	<20021031230136.GE4331@elf.ucw.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 01 Nov 2002 07:05:50 -0700
In-Reply-To: <20021031230136.GE4331@elf.ucw.cz>
Message-ID: <m1ela5gzb5.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> Hi!
> 
> > If you want I can dig up the drivers I am currently using and send
> > them to you.
> > 
> > I even have a working memory scrub routine.
> 
> What is "memory scrubbing" good for?

When you have a correctable ECC error on a page you need to rewrite the
memory to remove the error.  This prevents the correctable error from becoming
an uncorrectable error if another bit goes bad.  Also if you have a
working software memory scrub routine you can be certain multiple
errors from the same address are actually distinct.  As opposed to
multiple reports of the same error.

Eric
