Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289871AbSA3SX1>; Wed, 30 Jan 2002 13:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289917AbSA3SVt>; Wed, 30 Jan 2002 13:21:49 -0500
Received: from as2-1-8.va.g.bonet.se ([194.236.117.122]:61445 "EHLO
	ringstrom.mine.nu") by vger.kernel.org with ESMTP
	id <S290346AbSA3SVY>; Wed, 30 Jan 2002 13:21:24 -0500
Date: Wed, 30 Jan 2002 19:20:56 +0100 (CET)
From: Tobias Ringstrom <tori@ringstrom.mine.nu>
X-X-Sender: tori@boris.prodako.se
To: Corey Minyard <minyard@acm.org>
cc: Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: TCP/IP Speed
In-Reply-To: <3C583655.6060707@acm.org>
Message-ID: <Pine.LNX.4.44.0201301917110.14481-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002, Corey Minyard wrote:

> If I remember correctly, the TCP stacks put in delays for small sends so 

You do not remember correctly.  I think you are confused by Nagle and 
delayed ACKs.  If there is no unacknowledged data, a small packet will be 
sent immediately.

/Tobias

