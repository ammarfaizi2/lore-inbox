Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261910AbULPEGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbULPEGQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 23:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbULPEGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 23:06:15 -0500
Received: from ns.suse.de ([195.135.220.2]:16277 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261910AbULPEGN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 23:06:13 -0500
Date: Thu, 16 Dec 2004 05:06:08 +0100
From: Andi Kleen <ak@suse.de>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Arnd Bergmann <arnd@arndb.de>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, pavel@suse.cz, discuss@x86-64.org,
       gordon.jin@intel.com
Subject: Re: unregister_ioctl32_conversion and modules. ioctl32 revisited.
Message-ID: <20041216040608.GB32718@wotan.suse.de>
References: <200412151847.09598.arnd@arndb.de> <20041215182109.GA13539@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041215182109.GA13539@mellanox.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But what if you really wanted to return -ENOIOCTLCMD?

It's an internal error code as Arnd pointed out.

> And, the idea was to get rid of the hash eventually?

Just rid of the dynamic hash changes. I don't have any plans 
to convert all the static ioctls in fs/compat_ioctl.c (that would
be a lot of work without clear gain) 

-Andi
