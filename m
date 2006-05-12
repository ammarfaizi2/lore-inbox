Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbWELMte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbWELMte (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 08:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWELMte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 08:49:34 -0400
Received: from stinky.trash.net ([213.144.137.162]:471 "EHLO stinky.trash.net")
	by vger.kernel.org with ESMTP id S1751054AbWELMte (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 08:49:34 -0400
Message-ID: <4464845B.3010502@trash.net>
Date: Fri, 12 May 2006 14:49:31 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Jesper Juhl <jesper.juhl@gmail.com>,
       "David S. Miller" <davem@davemloft.net>, sfrost@snowman.net,
       gcoady.lk@gmail.com, laforge@netfilter.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       marcelo@kvack.org
Subject: Re: [PATCH] fix mem-leak in netfilter
References: <20060507093640.GF11191@w.ods.org> <egts52hm2epfu4g1b9kqkm4s9cdiv3tvt9@4ax.com> <20060508050748.GA11495@w.ods.org> <20060507.224339.48487003.davem@davemloft.net> <44643BFD.3040708@trash.net> <9a8748490605120409x3851ca4fn14fc9c52500701e4@mail.gmail.com> <44647280.1030602@trash.net> <9a8748490605120513w4b078642k816dfef6ab907823@mail.gmail.com> <20060512124041.GA31714@w.ods.org>
In-Reply-To: <20060512124041.GA31714@w.ods.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> Please post it to the list, this coding style needs far more than two
> pairs of eyes to be fixed. It has already discouraged several people,
> the more we will be, the least pain we will feel :-)

:)

I actually just got to fed up with this garbage (once again) and started
rewriting it from scratch, which looks like a lot less pain. I'll look
into these loops again for 2.4 and 2.6.17 once I'm done doing that.

