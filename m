Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267661AbTAHC0H>; Tue, 7 Jan 2003 21:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267662AbTAHC0H>; Tue, 7 Jan 2003 21:26:07 -0500
Received: from adsl-67-114-192-42.dsl.pltn13.pacbell.net ([67.114.192.42]:57628
	"EHLO mx1.corp.rackable.com") by vger.kernel.org with ESMTP
	id <S267661AbTAHC0G>; Tue, 7 Jan 2003 21:26:06 -0500
Message-ID: <3E1B8E2B.9060200@rackable.com>
Date: Tue, 07 Jan 2003 18:34:19 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Walt H <waltabbyh@mindspring.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Question for Marcelo
References: <3E1AFA70.4070200@mindspring.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Jan 2003 02:34:40.0264 (UTC) FILETIME=[7E876880:01C2B6BE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Walt H wrote:

> Hi Marcelo,
>
> I was just wondering if support for the Adaptec 79xx had been added to 
> 2.4.21-pre? I have a server with the dual channel 7902 support on 
> board, that so far appears to be working OK. It's using 2.4.20 with 
> the driver patched in from Adaptec's site. I found an earlier mail 
> from you stating that it would be added during the 2.4.20-pre cycle. 
> Are there problems with the driver I should be aware of? Thanks,
>
> -Walt
>
> PS. Please CC me in any replies, as I'm not subscribed to the list. 
> Thanks.

  I believe that he would prefer that it get tested in the ac tree 1st. 
 Alan seemed receptive to including it, but he's not doing much with the 
2.4 ac kernel any more.

http://marc.theaimsgroup.com/?l=linux-kernel&m=104106449418263&w=2


PS- All you really need to do to update the driver is delete 
drivers/scsi/aic7xxx, and replace it with the newer driver from Gibbs 
site.  Recompile and you are done.
http://people.freebsd.org/~gibbs/linux/SRC/
aic79xx-linux-2.4-20021230-tar.gz

-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>



