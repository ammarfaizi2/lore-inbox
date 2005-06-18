Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbVFRA5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbVFRA5k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 20:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVFRA5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 20:57:40 -0400
Received: from peabody.ximian.com ([130.57.169.10]:41628 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261500AbVFRA5j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 20:57:39 -0400
Subject: Re: [patch] inotify.
From: Robert Love <rml@novell.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@osdl.org>, John McCutchan <ttb@tentacle.dhs.org>,
       Christoph Hellwig <hch@lst.de>, zab@zabbo.net,
       linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <200506180205.08366.arnd@arndb.de>
References: <1118855899.3949.21.camel@betsy>
	 <20050617143334.41a31707.akpm@osdl.org> <1119044430.7280.22.camel@phantasy>
	 <200506180205.08366.arnd@arndb.de>
Content-Type: text/plain
Date: Fri, 17 Jun 2005 20:57:36 -0400
Message-Id: <1119056256.7280.27.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-06-18 at 02:05 +0200, Arnd Bergmann wrote:

> An explanation along the lines of "neither ioctl on cdev nor a syscall
> based approach is made everyone happy, so we decided to stick with the
> one that is already used" might give a little more insight.

I will add exactly this to the FAQ, thank you.

I suspect this is the situation that /dev/epoll faced, although in the
case of epoll, the opening the device did not have any real significance
(you would generally not restrict access and you would only open the
device once).

	Robert Love


