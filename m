Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267547AbUBSUVb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 15:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267552AbUBSUVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 15:21:31 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:4616 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267547AbUBSUV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 15:21:28 -0500
Date: Thu, 19 Feb 2004 20:21:25 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Greg KH <greg@kroah.com>
cc: linux-hotplug-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Re: HOWTO use udev to manage /dev
In-Reply-To: <20040219194610.GB13934@kroah.com>
Message-ID: <Pine.LNX.4.44.0402192020100.26894-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> udev can create different /dev nodes for these devices.  But as udev
> does not modify the kernel code at all, it can not "solve" the
> duplication of numbers in the kernel at all.  Nor is it meant to.

Okay. If I change the major number of serial ttys inside the kernel 
of course udev would properly handle this. Now the question is would this 
break userland applications using the serial port?


