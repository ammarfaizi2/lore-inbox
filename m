Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262595AbVGMFuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262595AbVGMFuS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 01:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262578AbVGMFuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 01:50:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16867 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262595AbVGMFuP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 01:50:15 -0400
Date: Tue, 12 Jul 2005 22:50:13 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb mass storage bug
Message-Id: <20050712225013.2e66d0fc.zaitcev@redhat.com>
In-Reply-To: <mailman.1121138161.21500.linux-kernel2news@redhat.com>
References: <20050711203047.39437.qmail@web33113.mail.mud.yahoo.com>
	<mailman.1121138161.21500.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0beta3 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jul 2005 20:09:58 -0700, Greg KH <greg@kroah.com> wrote:
> On Mon, Jul 11, 2005 at 01:30:47PM -0700, Joe Sevy wrote:
> > Sorry, no logs or dmesg to report; just performance.
> > Using kernel 2.6.12: USB flash drive (san-disk cruzer
> > micro) Copy FROM drive is normal and quick; copy TO
> > drive is amazingly slow. (30 minutes for 50K file).
> > Used same configuration as for 2.6.11.11. Cured by
> > going back to old kernel.
> 
> Are you using CONFIG_UB or CONFIG_USB_STORAGE?

Please, Greg. I knew that someone will try to implicate ub here, but you?
Consider two things:
 #1 Joe's kernel reads and writes and sharply different speeds,
    while ub is uniformly slow
 #2 It's a regression in 2.6.12

-- Pete
