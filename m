Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751949AbWCAXiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbWCAXiq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 18:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751953AbWCAXiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 18:38:46 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21657 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751949AbWCAXip (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 18:38:45 -0500
Date: Wed, 1 Mar 2006 15:40:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: greg@kroah.com, ebiederm@xmission.com, linux-kernel@vger.kernel.org,
       yanmin.zhang@intel.com
Subject: Re: + proc-dont-lock-task_structs-indefinitely-cpuset-fix-2.patch
 added to -mm tree
Message-Id: <20060301154053.73d9d348.akpm@osdl.org>
In-Reply-To: <20060301152039.ab2c453d.pj@sgi.com>
References: <20060228201040.34a1e8f5.pj@sgi.com>
	<m1irqypxf5.fsf@ebiederm.dsl.xmission.com>
	<20060228212501.25464659.pj@sgi.com>
	<20060228234807.55f1b25f.pj@sgi.com>
	<20060301002631.48e3800e.akpm@osdl.org>
	<20060301015338.b296b7ad.pj@sgi.com>
	<20060301192103.GA14320@kroah.com>
	<20060301125802.cce9ef51.pj@sgi.com>
	<20060301213048.GA17251@kroah.com>
	<20060301142631.22738f2d.akpm@osdl.org>
	<20060301225013.GA20834@kroah.com>
	<20060301152039.ab2c453d.pj@sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> > Oh, and Paul, this all works just fine with no -mm, right?
> 
> Do you mean - does 2.6.16-rc5 work for me?
> 
> I haven't tried that yet. The lowest I went in Andrew's 2.6.16-rc5-rc1
> patch stack was one patch, which would be 2.6.16-rc5 plus
> "linus.patch."

That's tip-of-linus-tree a day or so after -rc5.

> I will try a plain 2.6.16-rc5 as well, shortly.

I don't think there's much point in that - the sysfs-topology code went in
on Feb 15.

If 2.6.16-rc5+linus.patch works and
2.6.16-rc5+linus.patch+gregkh-driver-allow-sysfs-attribute-files-to-be-pollable.patch
crashes then we have a pretty good idea of where to look.

