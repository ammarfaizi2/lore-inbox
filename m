Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422631AbWJ3UrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422631AbWJ3UrP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 15:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422634AbWJ3UrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 15:47:15 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:667 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1422631AbWJ3UrO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 15:47:14 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.19-rc3-mm1 - udev doesn't work
Date: Mon, 30 Oct 2006 21:45:24 +0100
User-Agent: KMail/1.9.1
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
References: <20061029160002.29bb2ea1.akpm@osdl.org> <200610302115.37688.rjw@sisk.pl> <45466265.3010609@garzik.org>
In-Reply-To: <45466265.3010609@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610302145.24646.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 30 October 2006 21:36, Jeff Garzik wrote:
> Rafael J. Wysocki wrote:
> > The controller _is_ detected and handled properly, but udev is apparently
> > unable to create the special device files for SATA drives/partitions even
> > though CONFIG_SYSFS_DEPRECATED is set.
> 
> 
> Did you forget to enable CONFIG_BLK_DEV_SD or CONFIG_BLK_DEV_SR?

Well, I took a working .config from 2.6.19-rc2-mm2 and run 'make oldconfig'
on it. :-)  [CONFIG_BLK_DEV_SD=y and CONFIG_BLK_DEV_SR=m]

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
