Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270249AbRHMPTY>; Mon, 13 Aug 2001 11:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270247AbRHMPTP>; Mon, 13 Aug 2001 11:19:15 -0400
Received: from cmailg5.svr.pol.co.uk ([195.92.195.175]:20592 "EHLO
	cmailg5.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S270250AbRHMPTB>; Mon, 13 Aug 2001 11:19:01 -0400
Message-ID: <3B77EFE6.9020106@humboldt.co.uk>
Date: Mon, 13 Aug 2001 16:19:02 +0100
From: Adrian Cox <adrian@humboldt.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2+) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: tegeran@home.com
CC: linux-kernel@vger.kernel.org
Subject: Re: via82cxxx_audio driver bug?
In-Reply-To: <01081307194201.00276@c779218-a>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Knight wrote:
> I just sent email to the maintainer of the via82cxxx_audio driver 
> regarding this bug, hopefully I'll hear back from him soon, but I'd also 
> like to hear from anyone else who has used and/or hacked at this driver, 
> and if they've seen XMMS or other audio applications with access to 
> /dev/mixer have strange, temporarily lockups when not in root/realtime 
> priority. I've yet to be able to test this with other audio applications 
> besides XMMS.

Are you using 2.4.7 or 2.4.8? Those kernels have new code to talk to the 
AC97 codec, which cures lockups on some boards.
-- 
Adrian Cox   http://www.humboldt.co.uk/

