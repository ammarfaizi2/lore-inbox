Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbWEHIgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbWEHIgY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 04:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbWEHIgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 04:36:24 -0400
Received: from server1.secure-linux-server.com ([207.44.172.97]:49621 "EHLO
	server1.secure-linux-server.com") by vger.kernel.org with ESMTP
	id S932371AbWEHIgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 04:36:21 -0400
Message-ID: <445F02F1.1090604@ufomechanic.net>
Date: Mon, 08 May 2006 09:36:01 +0100
From: Amin Azez <azez@ufomechanic.net>
User-Agent: Thunderbird 1.5 (X11/20060309)
MIME-Version: 1.0
Newsgroups: gmane.comp.security.firewalls.netfilter.devel,gmane.linux.kernel
To: "David S. Miller" <davem@davemloft.net>
CC: sfrost@snowman.net, gcoady.lk@gmail.com, laforge@netfilter.org,
       jesper.juhl@gmail.com, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org, marcelo@kvack.org,
       Juergen.Kreileder@empolis.com
Subject: Re: [PATCH] fix mem-leak in netfilter
References: <20060507093640.GF11191@w.ods.org>	<egts52hm2epfu4g1b9kqkm4s9cdiv3tvt9@4ax.com>	<20060508050748.GA11495@w.ods.org> <20060507.224339.48487003.davem@davemloft.net>
In-Reply-To: <20060507.224339.48487003.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> From: Willy Tarreau <willy@w.ods.org>
> Date: Mon, 8 May 2006 07:07:48 +0200
> 
>> I wonder how such unmaintainable code has been merged in the first
>> place. Obviously, Davem has never seen it !
> 
> Oh I've seen ipt_recent.c, it's one huge pile of trash
> that needs to be rewritten.  It has all sorts of problems.
> 
> This is well understood on the netfilter-devel list and
> I am to understand that someone has taken up the task to
> finally rewrite the thing.


Is that Juergen.Kreileder@empolis.com ?
...just checking... he seemed to volunteer in December last year but
Stephen Frost has been taking recent questions.

Sam
