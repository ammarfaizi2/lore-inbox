Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965088AbVLNX0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965088AbVLNX0e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 18:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965087AbVLNX0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 18:26:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:420 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965088AbVLNX0d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 18:26:33 -0500
Date: Wed, 14 Dec 2005 15:26:15 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, katzj@redhat.com, zaitcev@redhat.com
Subject: Re: "block" symlink in sysfs for a multifunction device
Message-Id: <20051214152615.13b6b105.zaitcev@redhat.com>
In-Reply-To: <20051214055019.GA23036@kroah.com>
References: <20051212134904.225dcc5d.zaitcev@redhat.com>
	<20051214055019.GA23036@kroah.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.8; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2005 21:50:19 -0800, Greg KH <greg@kroah.com> wrote:

> $ ls -l /sys/block/uba/device/
> -r--r--r--  1 root root 4096 Dec 13 21:31 bNumEndpoints
> lrwxrwxrwx  1 root root    0 Dec 13 21:31 block:uba -> ../../../../../../block/uba
> lrwxrwxrwx  1 root root    0 Dec 13 21:31 block:ubb -> ../../../../../../block/ubb
> lrwxrwxrwx  1 root root    0 Dec 13 21:31 block:ubc -> ../../../../../../block/ubc
> lrwxrwxrwx  1 root root    0 Dec 13 21:31 block:ubd -> ../../../../../../block/ubd

Greg, Jeremy is not happy about this.

> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=175563
> ------- Additional Comments From katzj@redhat.com  2005-12-14 18:05 EST -------
> Actually, this is problematic.  It makes it so that the single device directory
> corresponds to more than one device which we can't handle with kudzu :-(

Sorry,
-- Pete
