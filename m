Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbWELHks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbWELHks (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 03:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbWELHks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 03:40:48 -0400
Received: from stinky.trash.net ([213.144.137.162]:190 "EHLO stinky.trash.net")
	by vger.kernel.org with ESMTP id S1751050AbWELHks (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 03:40:48 -0400
Message-ID: <44643BFD.3040708@trash.net>
Date: Fri, 12 May 2006 09:40:45 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: willy@w.ods.org, sfrost@snowman.net, gcoady.lk@gmail.com,
       laforge@netfilter.org, jesper.juhl@gmail.com,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       marcelo@kvack.org
Subject: Re: [PATCH] fix mem-leak in netfilter
References: <20060507093640.GF11191@w.ods.org>	<egts52hm2epfu4g1b9kqkm4s9cdiv3tvt9@4ax.com>	<20060508050748.GA11495@w.ods.org> <20060507.224339.48487003.davem@davemloft.net>
In-Reply-To: <20060507.224339.48487003.davem@davemloft.net>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> From: Willy Tarreau <willy@w.ods.org>
> Date: Mon, 8 May 2006 07:07:48 +0200
> 
> 
>>I wonder how such unmaintainable code has been merged in the first
>>place. Obviously, Davem has never seen it !
> 
> 
> Oh I've seen ipt_recent.c, it's one huge pile of trash
> that needs to be rewritten.  It has all sorts of problems.
> 
> This is well understood on the netfilter-devel list and
> I am to understand that someone has taken up the task to
> finally rewrite the thing.


I haven't seen any cleanup patches so far, so I think I'm
going to start my nth try at cleaning up this mess.
Unfortunately its even immune to Lindent ..
