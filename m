Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932549AbWEVHIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549AbWEVHIp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 03:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbWEVHIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 03:08:44 -0400
Received: from dsl027-180-173.sfo1.dsl.speakeasy.net ([216.27.180.173]:34207
	"EHLO picasso.davemloft.net") by vger.kernel.org with ESMTP
	id S932543AbWEVHIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 03:08:44 -0400
Date: Sat, 06 Aug 2005 08:49:50 -0700 (PDT)
Message-Id: <20050806.084950.74730249.davem@davemloft.net>
To: olh@suse.de
Cc: bboissin@gmail.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org
Subject: Re: [PATCH] implicit declaration of function `page_cache_release'
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050806150103.GA21821@suse.de>
References: <40f323d00508051218c30d7af@mail.gmail.com>
	<20050806.065520.85401639.davem@davemloft.net>
	<20050806150103.GA21821@suse.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olaf Hering <olh@suse.de>
Date: Sat, 6 Aug 2005 17:01:03 +0200

> So the patch should be reverted? Its only for CONFIG_SWAP=n, rather
> unusual for KDE/GNOME tainted workstations...

Not necessarily, but the header dependencies should be fixed
up somehow.
