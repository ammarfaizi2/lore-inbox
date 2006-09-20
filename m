Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbWITWKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWITWKN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 18:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWITWKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 18:10:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40333 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932283AbWITWKL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 18:10:11 -0400
Date: Wed, 20 Sep 2006 15:09:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jiri Kosina <jikos@jikos.cz>
Cc: linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
       Greg KH <greg@kroah.com>
Subject: Re: USB: fix autosuspend-autoresume with CONFIGRe: 2.6.19 -mm merge
 plans
Message-Id: <20060920150918.abe0288d.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609202345590.13974@twin.jikos.cz>
References: <20060920135438.d7dd362b.akpm@osdl.org>
	<Pine.LNX.4.64.0609202345590.13974@twin.jikos.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006 23:53:23 +0200 (CEST)
Jiri Kosina <jikos@jikos.cz> wrote:

> On Wed, 20 Sep 2006, Andrew Morton wrote:
> 
> > fix-gregkh-usb-usbcore-add-autosuspend-autoresume-infrastructure.patch
> > gregkh-usb-usbcore-add-autosuspend-autoresume-infrastructure-2.patch
> 
> Hi Andrew,
> 
> a few days ago I submitted a patch [1] to autosupend-autoresume 
> infrastructure (and Alan Stern submitted a similar patch a few hours later 
> [2]). 
> 
> Without this one-liner, all kernels compiled without CONFIG_USB_SUSPEND 
> will be unable to perform more than one suspend/resume cycle, which is 
> quite annoying. Would you please reconsider pushing these together with 
> other autosuspend/autoresume infrastructure fixes?
> 
> Thanks.
> 
> [1] http://lkml.org/lkml/2006/9/18/290
> [2] http://lkml.org/lkml/2006/9/19/93

I expect the appropriate fixes will automagically appear in Greg's tree, to
be picked up in next -mm.  Perhaps they already have appeared - Alan?
