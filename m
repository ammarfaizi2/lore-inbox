Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267578AbUIOVgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267578AbUIOVgo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 17:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267549AbUIOVdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:33:51 -0400
Received: from peabody.ximian.com ([130.57.169.10]:61379 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267438AbUIOV1z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:27:55 -0400
Subject: Re: [patch] kernel sysfs events layer
From: Robert Love <rml@novell.com>
To: Greg KH <greg@kroah.com>
Cc: Kay Sievers <kay.sievers@vrfy.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040915212110.GA25840@kroah.com>
References: <20040906020601.GA3199@vrfy.org>
	 <20040910235409.GA32424@kroah.com> <1094875775.10625.5.camel@lucy>
	 <20040911165300.GA17028@kroah.com> <20040913144553.GA10620@vrfy.org>
	 <20040915000753.GA24125@kroah.com> <1095211167.20763.2.camel@localhost>
	 <20040915034455.GB30747@kroah.com> <20040915194018.GC24131@kroah.com>
	 <1095279043.23385.102.camel@betsy.boston.ximian.com>
	 <20040915212110.GA25840@kroah.com>
Content-Type: text/plain
Date: Wed, 15 Sep 2004 17:26:54 -0400
Message-Id: <1095283614.23385.119.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-15 at 14:21 -0700, Greg KH wrote:

> Doh!  You're right.  Here's Kay's patch ported to the new interface, and
> adding a umount event type.  I've applied it to my trees.

I am actually thinking that Kay's approach is less than ideal, since it
does not catch all mounts and unmounts.

	Robert Love


