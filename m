Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbWIOXKD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWIOXKD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 19:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbWIOXKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 19:10:01 -0400
Received: from xenotime.net ([66.160.160.81]:7618 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932354AbWIOXKA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 19:10:00 -0400
Date: Fri, 15 Sep 2006 16:11:11 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: rossb <rossb@google.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mm-commits@vger.kernel.org,
       akpm@google.com, sam@ravnborg.org
Subject: Re: + allow-proc-configgz-to-be-built-as-a-module.patch added to
 -mm tree
Message-Id: <20060915161111.8115e2ca.rdunlap@xenotime.net>
In-Reply-To: <d43160c70609151604pfe83b3nc130f2abc250baa6@mail.google.com>
References: <200609152158.k8FLw7ud018089@shell0.pdx.osdl.net>
	<20060915154752.d7bdb8a0.rdunlap@xenotime.net>
	<d43160c70609151604pfe83b3nc130f2abc250baa6@mail.google.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2006 19:04:30 -0400 rossb wrote:

> On 9/15/06, Randy.Dunlap <rdunlap@xenotime.net> wrote:
> > > In some ways this is a bit risky, because the .config which is used for
> > > compiling kernel/configs.c isn't necessarily the same as the .config which was
> > > used to build vmlinux.
> >
> > and that's why a module wasn't allowed.
> > It's not worth the risk IMO.
> 
> It's not worth the risk for distributions or if you are tyring to
> support people building their own kernels.  But if you are in an
> environment where you have enough control that you are not worried the
> kernel and the module being built at separate times or with different
> configs, then it's a nice compromise between convenience and memory
> use.

One can have any number of private kernel patches, too.
Or put another way:  Just because it can be done doesn't mean
that it should be done.

And I'm still interested in the other questions that were not answered.

---
~Randy
