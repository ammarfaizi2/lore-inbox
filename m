Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932589AbVHJXAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932589AbVHJXAb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 19:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932590AbVHJXAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 19:00:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28393 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932589AbVHJXAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 19:00:30 -0400
Date: Wed, 10 Aug 2005 16:00:27 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: DervishD <lkml@dervishd.net>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: Problem with usb-storage and /dev/sd?
Message-Id: <20050810160027.04360a78.zaitcev@redhat.com>
In-Reply-To: <mailman.1123702259.29404.linux-kernel2news@redhat.com>
References: <mailman.1123702259.29404.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2005 21:22:43 +0200, DervishD <lkml@dervishd.net> wrote:

>     I'm not using hotplug currently so... how can I make the USB
> subsystem to assign always the same /dev/sd? entry to my USB Mass
> storage devices? [...]

You cannot. Just mount by label or something... Better yet, install
something like Fedora Core 4, which uses HAL, and forget about it.
The fstab-sync takes care of the rest.

-- Pete
