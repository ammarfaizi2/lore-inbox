Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbVAaCVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbVAaCVY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 21:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbVAaCVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 21:21:24 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:14321 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261891AbVAaCVU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 21:21:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=VvFjwMawjeSgsijtyfvsgPRaVHMRc+zu4XtuzLEk8lFkq2uSLuweNPBCVmlVu3Xpj+EuD+KUv68mxvZ40qIzMjnp/HODF1WENFLCp+AE4IHpJ5uxbGkIPBtPsl8054/hwgB8mjpIAGOLp09HOB95D5jy/S2pTReCSmBQ4C9ClRM=
Message-ID: <35fb2e590501301821410eb605@mail.gmail.com>
Date: Mon, 31 Jan 2005 02:21:19 +0000
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Eugene K <evgfpeters@yahoo.com>
Subject: Re: Interface between BSP and the kernel
Cc: lunux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050130220617.91509.qmail@web51002.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050130220617.91509.qmail@web51002.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jan 2005 14:06:17 -0800 (PST), Eugene K <evgfpeters@yahoo.com> wrote:

> Where could I find a documented interface between a
> Board Support Package layer and Linux Kernel itself ?

There is no Board Support Package layer of which you speak. Linux
doesn't have a hal (well it does, but it's a userspace solution to a
different problem) like you might be used to.

> Will highly appreciate any kind of pointers.

Perhaps if you can provide some specific information about what you
want to do, then we can point you in the correct direction. For
example, were you to be developing on a Freescale board I would point
you towards the linuxppc-embedded lists on ozlabs.org. For ARM boards
you would probably head over to the arm.linux.org.uk website.

There are various books available on kernel hacking and device
drivers. Jonathan Corbet says a new version of Linux Device Drivers
will be out soon, that covers kernel 2.6 (kudos to Jon for the earlier
books, as he mentions on http://www.lwn.net/, it's not going to be
easy to document this moving target) while several other more generic
books exist. Check out material available on the LWN site and refer
also to the http://www.kernelnewbies.org/ webiste and IRC channel for
more generic assistance.

Consider also various training and professional consulting services
available from your board vendor or Linux supplier.

Jon.
