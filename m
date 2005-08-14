Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbVHNIA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbVHNIA5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 04:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbVHNIA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 04:00:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37004 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932415AbVHNIA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 04:00:56 -0400
Date: Sun, 14 Aug 2005 01:00:47 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: usb camera failing in 2.6.13-rc6
Message-Id: <20050814010047.4b5fd37e.zaitcev@redhat.com>
In-Reply-To: <mailman.1124005092.8274.linux-kernel2news@redhat.com>
References: <mailman.1124005092.8274.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Aug 2005 17:12:06 +1000, Con Kolivas <kernel@kolivas.org> wrote:

> A digital camera which was working fine in 2.6.11/12 now fails on 2.6.13-rc6 
> (not sure when it started failing).

Does it continue to work on an older kernel? I saw a USB device breaking
right in the moment of reboot into a new kernel (thus prompting a week
of diffing an head-scratching).

> +usbmon: debugs is not available

Deconfigure CONFIG_USB_MON. It's useless without debugfs anyway.

-- Pete
