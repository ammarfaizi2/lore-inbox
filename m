Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262700AbUK0BQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262700AbUK0BQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 20:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbUK0BNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 20:13:33 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:60944 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S262700AbUK0BMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 20:12:14 -0500
Message-ID: <41A7C6A3.4040602@conectiva.com.br>
Date: Fri, 26 Nov 2004 22:13:23 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Organization: Conectiva S.A.
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tobias DiPasquale <codeslinger@gmail.com>
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH][REVISED] add list_del_head[_init] functions
References: <876ef97a0411261638988b9aa@mail.gmail.com>
In-Reply-To: <876ef97a0411261638988b9aa@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tobias DiPasquale wrote:
> Hi all,
> 
> I revised my earlier list_del_head patch and took Jens' suggestions.
> There were two function additions:
> 
> list_del_head() - removes the head of a list and returns it
> list_del_head_init() - removes the head of a list, reinitializes it
> and returns it
> 
> I have also converted several obvious pieces of code in kernel/, net/
> and mm/ to use these new functions. The patch for all of this is
> attached. Thanks :)
> 
> Name: Add list_del_head[_init] functions for full queue API
> Status: Tested (smoke tests, mostly)
> Signed-off-by: Toby DiPasquale <codeslinger@gmail.com>
> 
> P.S. Again, please CC me on any replies as I'm not subscribed to LKML.
> Thanks again :)
> 

The net_rx_action one doesn't look right.

- Arnaldo
