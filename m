Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269194AbRGaGbF>; Tue, 31 Jul 2001 02:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269193AbRGaGa4>; Tue, 31 Jul 2001 02:30:56 -0400
Received: from Huntington-Beach.blue-labs.org ([208.179.59.198]:88 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S269194AbRGaGat>; Tue, 31 Jul 2001 02:30:49 -0400
Message-ID: <3B664FE2.9090702@blue-labs.org>
Date: Tue, 31 Jul 2001 02:27:46 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2+) Gecko/20010730
X-Accept-Language: en-us
MIME-Version: 1.0
To: Tony.Lill@ajlc.waterloo.on.ca
CC: linux-kernel@vger.kernel.org
Subject: Re: laptops and journalling filesystems
In-Reply-To: <200107310254.WAA22236@spider.ajlc.waterloo.on.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

My laptop works quite well with reiserfs, maybe you have some program 
that is doing the diddling?  Once my disk goes to sleep, it stays asleep 
until I do something that isn't in the cache or needs to be written out 
of the cache.

David

Tony Lill wrote:

>Do any of the current batch of journalling filesystems NOT diddle the
>disk every 5 seconds? I've tried reiser and ext3 and they're both
>antithetic to spinning down the disk. Any plans to fix this bug in
>future kernels?
>--
>Tony Lill,                         Tony.Lill@AJLC.Waterloo.ON.CA
>President, A. J. Lill Consultants        fax/data (519) 650 3571
>539 Grand Valley Dr., Cambridge, Ont. N3H 2S2     (519) 241 2461
>--------------- http://www.ajlc.waterloo.on.ca/ ----------------
>"Welcome to All Things UNIX, where if it's not UNIX, it's CRAP!"
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>



