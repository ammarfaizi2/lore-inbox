Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbWCACqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbWCACqR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 21:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbWCACqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 21:46:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17638 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964846AbWCACqQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 21:46:16 -0500
Date: Tue, 28 Feb 2006 18:36:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: + proc-dont-lock-task_structs-indefinitely-cpuset-fix-2.patch
 added to -mm tree
Message-Id: <20060228183610.5253feb9.akpm@osdl.org>
In-Reply-To: <20060228181849.faaf234e.pj@sgi.com>
References: <200603010120.k211KqVP009559@shell0.pdx.osdl.net>
	<20060228181849.faaf234e.pj@sgi.com>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.12; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> However, I have some debugging to do on this kernel first.
> 
> It blows up on boot (ia64 sn2_defconfig).
> 
> I haven't started to analyze it any yet.  I don't know if it's a bug
> or pilot error yet.

-rc5-mm1 appears to be a trainwreck.  It's a bit of a mystery - I've tried
several further configs and it all works swimmingly.

Hopefully some of the people who are hitting this will be able to tell us
whether http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.16-rc5-mm1.1.gz
or http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.16-rc5-mm1.2.gz work
OK, so I know how much to drop..
