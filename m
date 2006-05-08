Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbWEHFni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWEHFni (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 01:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbWEHFni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 01:43:38 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:61339
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932316AbWEHFnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 01:43:37 -0400
Date: Sun, 07 May 2006 22:43:39 -0700 (PDT)
Message-Id: <20060507.224339.48487003.davem@davemloft.net>
To: willy@w.ods.org
Cc: gcoady.lk@gmail.com, sfrost@snowman.net, laforge@netfilter.org,
       jesper.juhl@gmail.com, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org, marcelo@kvack.org
Subject: Re: [PATCH] fix mem-leak in netfilter
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060508050748.GA11495@w.ods.org>
References: <20060507093640.GF11191@w.ods.org>
	<egts52hm2epfu4g1b9kqkm4s9cdiv3tvt9@4ax.com>
	<20060508050748.GA11495@w.ods.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willy Tarreau <willy@w.ods.org>
Date: Mon, 8 May 2006 07:07:48 +0200

> I wonder how such unmaintainable code has been merged in the first
> place. Obviously, Davem has never seen it !

Oh I've seen ipt_recent.c, it's one huge pile of trash
that needs to be rewritten.  It has all sorts of problems.

This is well understood on the netfilter-devel list and
I am to understand that someone has taken up the task to
finally rewrite the thing.
