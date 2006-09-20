Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWITVyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWITVyA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 17:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWITVyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 17:54:00 -0400
Received: from twin.jikos.cz ([213.151.79.26]:12747 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S932214AbWITVx7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 17:53:59 -0400
Date: Wed, 20 Sep 2006 23:53:23 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
       Greg KH <greg@kroah.com>
Subject: USB: fix autosuspend-autoresume with CONFIGRe: 2.6.19 -mm merge
 plans
In-Reply-To: <20060920135438.d7dd362b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0609202345590.13974@twin.jikos.cz>
References: <20060920135438.d7dd362b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006, Andrew Morton wrote:

> fix-gregkh-usb-usbcore-add-autosuspend-autoresume-infrastructure.patch
> gregkh-usb-usbcore-add-autosuspend-autoresume-infrastructure-2.patch

Hi Andrew,

a few days ago I submitted a patch [1] to autosupend-autoresume 
infrastructure (and Alan Stern submitted a similar patch a few hours later 
[2]). 

Without this one-liner, all kernels compiled without CONFIG_USB_SUSPEND 
will be unable to perform more than one suspend/resume cycle, which is 
quite annoying. Would you please reconsider pushing these together with 
other autosuspend/autoresume infrastructure fixes?

Thanks.

[1] http://lkml.org/lkml/2006/9/18/290
[2] http://lkml.org/lkml/2006/9/19/93

-- 
Jiri Kosina
