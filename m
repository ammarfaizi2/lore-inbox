Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267454AbUIHN0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267454AbUIHN0j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 09:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267660AbUIHNA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 09:00:56 -0400
Received: from holomorphy.com ([207.189.100.168]:58791 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267568AbUIHNAS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 09:00:18 -0400
Date: Wed, 8 Sep 2004 06:00:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com
Subject: Re: 2.6.9-rc1-mm4
Message-ID: <20040908130015.GD3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	dhowells@redhat.com
References: <20040907020831.62390588.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907020831.62390588.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 02:08:31AM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm4/
> - Added Dave Howells' mysterious CacheFS.
> - Various new fixes, cleanups and bugs, as usual.

Some Kconfig dependencies need to be added for the cachefs bits.

In file included from fs/afs/vnode.h:16,
                 from fs/afs/callback.c:20:
include/linux/cachefs.h:347:2: #error 


-- wli
