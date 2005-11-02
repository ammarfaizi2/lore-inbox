Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751525AbVKBF6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbVKBF6M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 00:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbVKBF6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 00:58:12 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:25608 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751504AbVKBF6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 00:58:11 -0500
Date: Wed, 2 Nov 2005 06:47:02 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Yan Zheng <yzcorp@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       David Stevens <dlstevens@us.ibm.com>
Subject: Re: [PATCH][MCAST]IPv6: small fix for ip6_mc_msfilter(...)
Message-ID: <20051102054702.GB11266@alpha.home.local>
References: <436586F0.9080101@21cn.com> <7e77d27c0511010237x775529b8h@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e77d27c0511010237x775529b8h@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 01, 2005 at 06:37:43PM +0800, Yan Zheng wrote:
> You can reproduce this bug by follow codes. This program will cause a
> change to include report even though the first socket's filter mode is
> exclude.

I've not clearly understood the nature of the bug, does it also
affect 2.4 ? Marcelo will be releasing 2.4.32 in a few days, so
it would be wise to merge the fix soon.

Regards,
Willy

