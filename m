Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130013AbRAXUco>; Wed, 24 Jan 2001 15:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129632AbRAXUce>; Wed, 24 Jan 2001 15:32:34 -0500
Received: from falcon.etf.bg.ac.yu ([147.91.8.233]:17932 "EHLO
	falcon.etf.bg.ac.yu") by vger.kernel.org with ESMTP
	id <S130379AbRAXUcX>; Wed, 24 Jan 2001 15:32:23 -0500
Date: Wed, 24 Jan 2001 21:31:25 +0100 (CET)
From: Boris Dragovic <lynx@falcon.etf.bg.ac.yu>
To: Chris Wedgwood <cw@f00f.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: select() on TCP socket sleeps for 1 tick even if data
  available
In-Reply-To: <20010121133433.A1112@metastasis.f00f.org>
Message-ID: <Pine.LNX.4.20.0101242130100.14881-100000@falcon.etf.bg.ac.yu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


can someone explain what is nagle or pinpoint explanation :)

lynx


On Sun, 21 Jan 2001, Chris Wedgwood wrote:

> On Sat, Jan 20, 2001 at 07:35:12PM -0500, Dan Maas wrote:
>     
>     Bingo! With this fix, 2.2.18 performance becomes almost identical to 2.4.0
>     performance. I assume 2.4.0 disables Nagle by default on local
>     connections...
> 
> 2.4.x has a smarter nagle algorithm.
> 
> 
> 
>   --cw
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
