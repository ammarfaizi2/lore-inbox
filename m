Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUDBCpR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 21:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263136AbUDBCpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 21:45:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:20155 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263117AbUDBCpN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 21:45:13 -0500
Date: Thu, 1 Apr 2004 18:45:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chris Wright <chrisw@osdl.org>
Cc: andrea@suse.de, chrisw@osdl.org, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: disable-cap-mlock
Message-Id: <20040401184507.1f01920d.akpm@osdl.org>
In-Reply-To: <20040401183312.Z21045@build.pdx.osdl.net>
References: <20040401135920.GF18585@dualathlon.random>
	<20040401170705.Y22989@build.pdx.osdl.net>
	<20040401173034.16e79fee.akpm@osdl.org>
	<20040401175914.A22989@build.pdx.osdl.net>
	<20040402020915.GO18585@dualathlon.random>
	<20040401183026.6844597a.akpm@osdl.org>
	<20040401183312.Z21045@build.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> wrote:
>
> * Andrew Morton (akpm@osdl.org) wrote:
> > Andrea Arcangeli <andrea@suse.de> wrote:
> > > just curious, how does this work through 'su'? Does su check
> > > logincap.conf too?
> > 
> > I guess so.
> 
> Or let pam_cap do it so you don't have to modify all the apps just the pam
> confs.

Well the message I'm receiving is that the userspace capability
infrastructure is a decrepit mess which nobody is fixing or maintaining.

Certainly, if we could arrange for pam_cap to be fixed and proselytized
that would be even better than bolting new workalike code into login and
su.

