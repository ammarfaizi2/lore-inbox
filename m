Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266763AbUGUWWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266763AbUGUWWu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 18:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266764AbUGUWWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 18:22:49 -0400
Received: from levante.wiggy.net ([195.85.225.139]:27308 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S266761AbUGUWUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 18:20:09 -0400
Date: Thu, 22 Jul 2004 00:20:08 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] delete devfs
Message-ID: <20040721222008.GG25218@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040721141524.GA12564@kroah.com> <E1BnIHx-0003Py-00@chiark.greenend.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1BnIHx-0003Py-00@chiark.greenend.org.uk>
User-Agent: Mutt/1.5.6+20040523i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Matthew Garrett wrote:
> The new Debian installer requires devfs on several architectures, even
> for 2.6 installs. That's unlikely to get changed before release.

The Debian installer did not have a choice: until very recently udev was
not quite up to the task and having all devices on a filesystem simply
takes too much space. So for the next Debian release the installer will
have to rely on devfs. But since it is based on 2.4 kernels anyway that
isn't a problem.

For the release after sarge d-i will probably have to switch to a 2.6
kernel with hotplug, but that is a long way off at the moment.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
