Return-Path: <linux-kernel-owner+w=401wt.eu-S1750949AbXAQOpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbXAQOpB (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 09:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbXAQOpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 09:45:01 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:49934 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750949AbXAQOo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 09:44:59 -0500
Date: Wed, 17 Jan 2007 17:39:51 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Jamal Hadi Salim <hadi@cyberus.ca>,
       Ingo Molnar <mingo@elte.hu>, linux-fsdevel@vger.kernel.org
Subject: Re: [take33 10/10] kevent: Kevent based AIO (aio_sendfile()/aio_sendfile_path()).
Message-ID: <20070117143950.GA19434@2ka.mipt.ru>
References: <11690154353959@2ka.mipt.ru> <11690154352501@2ka.mipt.ru> <20070117135142.GA24866@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20070117135142.GA24866@in.ibm.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 17 Jan 2007 17:40:02 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2007 at 07:21:42PM +0530, Suparna Bhattacharya (suparna@in.ibm.com) wrote:
> 
> Since you are implementing new APIs here, have you considered doing an
> aio_sendfilev to be able to send a header with the data ?

It is doable, but why people do not like corking?
With Linux less than microsecond syscall overhead it is better and more
flexible solution, doesn't it?

I'm not saying - 'no, there will not be any *v variants', just getting
more info.

> Regards
> Suparna

-- 
	Evgeniy Polyakov
