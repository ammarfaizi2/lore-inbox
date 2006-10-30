Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751995AbWJ3UhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995AbWJ3UhJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 15:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751997AbWJ3UhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 15:37:09 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:59285 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751995AbWJ3UhH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 15:37:07 -0500
Message-ID: <45466265.3010609@garzik.org>
Date: Mon, 30 Oct 2006 15:36:53 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc3-mm1 - udev doesn't work
References: <20061029160002.29bb2ea1.akpm@osdl.org> <200610302055.21305.rjw@sisk.pl> <20061030200414.GA938@kroah.com> <200610302115.37688.rjw@sisk.pl>
In-Reply-To: <200610302115.37688.rjw@sisk.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> The controller _is_ detected and handled properly, but udev is apparently
> unable to create the special device files for SATA drives/partitions even
> though CONFIG_SYSFS_DEPRECATED is set.


Did you forget to enable CONFIG_BLK_DEV_SD or CONFIG_BLK_DEV_SR?

	Jeff


