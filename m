Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVCEUJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVCEUJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 15:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVCEUIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 15:08:51 -0500
Received: from smartmx-06.inode.at ([213.229.60.38]:32487 "EHLO
	smartmx-06.inode.at") by vger.kernel.org with ESMTP id S261167AbVCETKY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 14:10:24 -0500
Message-ID: <422A041E.40105@inode.info>
Date: Sat, 05 Mar 2005 20:10:22 +0100
From: Richard Fuchs <richard.fuchs@inode.info>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Scott Feldman <sfeldma@pobox.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: slab corruption in skb allocs
References: <42283093.7040405@inode.info> <20050304035309.1da7774e.akpm@osdl.org> <42285354.5090900@inode.info> <93832c6db45c33f7b2f195aae0d469dc@pobox.com>
In-Reply-To: <93832c6db45c33f7b2f195aae0d469dc@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott Feldman wrote:

> Was NAPI turned on for e100 in 2.6.7?  If not, turn NAPI on in the 2.6.7 
> driver and see if you get the same result.  If you do, it's very likely 
> the bug is in the e100 driver's NAPI implementation.

looks like you are right, enabling NAPI in 2.6.7 does trigger this.

what exactly is this? i didn't enable NAPI in any of the newer kernel 
versions i was trying, so i'm somewhat confused. :)  also, does this 
affect the e1000 driver in any way?

cheers
richard
