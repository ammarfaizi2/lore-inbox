Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWEAFki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWEAFki (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 01:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWEAFki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 01:40:38 -0400
Received: from terminus.zytor.com ([192.83.249.54]:62630 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751248AbWEAFkh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 01:40:37 -0400
Message-ID: <44559F35.2050800@zytor.com>
Date: Sun, 30 Apr 2006 22:40:05 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: NeilBrown <neilb@suse.de>
CC: Andrew Morton <akpm@osdl.org>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 005 of 11] md: Merge raid5 and raid6 code
References: <20060501152229.18367.patches@notabene> <1060501053025.22961@suse.de>
In-Reply-To: <1060501053025.22961@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NeilBrown wrote:
> There is a lot of commonality between raid5.c and raid6main.c.  This
> patches merges both into one module called raid456.  This saves a lot
> of code, and paves the way for online raid5->raid6 migrations.
> 
> There is still duplication, e.g. between handle_stripe5 and
> handle_stripe6.  This will probably be cleaned up later.
> 
> Cc:  "H. Peter Anvin" <hpa@zytor.com>
> Signed-off-by: Neil Brown <neilb@suse.de>
> 

Wonderful!  Thank you for doing this :)

	-hpa
