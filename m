Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270694AbRHNStD>; Tue, 14 Aug 2001 14:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270693AbRHNSsx>; Tue, 14 Aug 2001 14:48:53 -0400
Received: from mail16.svr.pol.co.uk ([195.92.193.217]:8480 "EHLO
	mail16.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S270695AbRHNSsh>; Tue, 14 Aug 2001 14:48:37 -0400
Message-ID: <3B793E4E.8010000@humboldt.co.uk>
Date: Tue, 14 Aug 2001 16:05:50 +0100
From: Adrian Cox <adrian@humboldt.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2+) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: John Weber <weber@nyc.rr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: via82cxxx_audio driver bug?
In-Reply-To: <fa.csmnkev.1i5mrbt@ifi.uio.no> <fa.fu9gjtv.lli1j7@ifi.uio.no> <3B793D00.4090501@nyc.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Weber wrote:

> I would get you the AC97 Codec ID if I knew how to get it, but
> the rest of the info is here.

It's in the startup messages of the driver.
Try dmesg | grep ac97
or
grep ac97 /var/log/dmesg (or wherever else your distribution puts them).

-- 
Adrian Cox   http://www.humboldt.co.uk/

