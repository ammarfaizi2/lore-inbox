Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbTEALh6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 07:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbTEALh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 07:37:58 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:13328 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S261214AbTEALh5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 07:37:57 -0400
Date: Thu, 1 May 2003 13:45:06 +0200
From: Willy TARREAU <willy@w.ods.org>
To: hugang <hugang@soulinfo.com>
Cc: Willy TARREAU <willy@w.ods.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Faster generic_fls
Message-ID: <20030501114506.GB308@pcw.home.local>
References: <200304300446.24330.dphillips@sistina.com> <20030430135512.6519eb53.akpm@digeo.com> <20030501131605.02066260.hugang@soulinfo.com> <20030501102230.GA308@pcw.home.local> <20030501191730.76b9d986.hugang@soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030501191730.76b9d986.hugang@soulinfo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 01, 2003 at 07:17:30PM +0800, hugang wrote:
 
> Do see the mail by Andrew Morton? -----

no sorry, I didn't see it, but I've read it now. I agree with him, that's
what I noticed here too. I also tried a binary search through the table in a
tree-like fashion, but the CPU doesn't like going back and forth through the
table at all ! I'm retrying with an "elastic mask".

Cheers
Willy

