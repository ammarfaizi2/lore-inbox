Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267368AbUIOUSB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267368AbUIOUSB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 16:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267358AbUIOUQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 16:16:38 -0400
Received: from peabody.ximian.com ([130.57.169.10]:3779 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267370AbUIOULp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 16:11:45 -0400
Subject: Re: [patch] kernel sysfs events layer
From: Robert Love <rml@novell.com>
To: Greg KH <greg@kroah.com>
Cc: Kay Sievers <kay.sievers@vrfy.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040915194018.GC24131@kroah.com>
References: <1094353088.2591.19.camel@localhost>
	 <20040905121814.GA1855@vrfy.org> <20040906020601.GA3199@vrfy.org>
	 <20040910235409.GA32424@kroah.com> <1094875775.10625.5.camel@lucy>
	 <20040911165300.GA17028@kroah.com> <20040913144553.GA10620@vrfy.org>
	 <20040915000753.GA24125@kroah.com> <1095211167.20763.2.camel@localhost>
	 <20040915034455.GB30747@kroah.com>  <20040915194018.GC24131@kroah.com>
Content-Type: text/plain
Date: Wed, 15 Sep 2004 16:10:43 -0400
Message-Id: <1095279043.23385.102.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-15 at 12:40 -0700, Greg KH wrote:

> And here's the patch I applied to my trees and will show up in the next
> -mm release.
> 
> I'll go convert Kay's mount patch to the new interface and add it too.

I think you want an "unmount" signal, too.

> (and yes, I've added a "change" event that drivers and such can use to
> tell userspace they they need to go look at a specific sysfs file.  I
> figured that this was going to be the next action request so I might as
> well add it now...)

Good.

	Robert Love


