Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272317AbRIEUel>; Wed, 5 Sep 2001 16:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272315AbRIEUec>; Wed, 5 Sep 2001 16:34:32 -0400
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:46090 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S272314AbRIEUeS>; Wed, 5 Sep 2001 16:34:18 -0400
Message-ID: <3B968B82.80405@zk3.dec.com>
Date: Wed, 05 Sep 2001 16:30:58 -0400
From: Peter Rival <frival@zk3.dec.com>
Organization: Tru64 QMG Performance Engineering
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: Jonathan Lahr <lahr@us.ibm.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: io_request_lock/queue_lock patch
In-Reply-To: <20010830134930.F23680@us.ibm.com> <20010831075613.A2855@suse.de> <20010831075201.N23680@us.ibm.com> <20010831200333.A9069@suse.de> <20010831113308.A28193@us.ibm.com> <20010903090703.C6875@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> You are now browsing the request list without agreeing on what lock is
> being held -- what happens to drivers assuming that io_request_lock
> protects the list? Boom. For 2.4 we simply cannot afford to muck around
> with this, it's jsut too dangerous. For 2.5 I already completely removed
> the io_request_lock (also helps to catch references to it from drivers).

Is this part of the bio patches?  (I confess, I haven't had the time to 
look yet.)  If not, do you know when we'll be seeing sneak previews of 
this code?  (Yes, it's me again! ;)

  - Pete

