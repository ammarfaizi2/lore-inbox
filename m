Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbVLNG6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbVLNG6Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 01:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbVLNG6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 01:58:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:26293 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751271AbVLNG6W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 01:58:22 -0500
Date: Tue, 13 Dec 2005 22:58:08 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "block" symlink in sysfs for a multifunction device
Message-Id: <20051213225808.5b959b88.zaitcev@redhat.com>
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

> -r--r--r--  1 root root 4096 Dec 13 21:31 bNumEndpoints
> lrwxrwxrwx  1 root root    0 Dec 13 21:31 block:uba -> ../../../../../../block/uba

> This will also fix the problem for floppy devices, like Russell pointed
> out.  Look good to you?

Poking installer people for an opinion now (they filed the bug).

-- Pete
