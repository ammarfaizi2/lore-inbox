Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264881AbUFARjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbUFARjo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 13:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264921AbUFARjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 13:39:44 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:29179 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S264881AbUFARjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 13:39:41 -0400
Message-ID: <40BCBF2E.7030802@minimum.se>
Date: Tue, 01 Jun 2004 19:38:54 +0200
From: Martin Olsson <mnemo@minimum.se>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: why swap at all? (what the user feels)
References: <200405290037.17775.vda@port.imtp.ilyichevsk.odessa.ua> <E1BTpqM-0005LZ-00@calista.eckenfels.6bone.ka-ip.net> <20040531104928.GA1465@ncsu.edu> <40BC6F0C.7000602@vision.ee> <20040601164946.GA22798@ncsu.edu>
In-Reply-To: <20040601164946.GA22798@ncsu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 From a pure *users* perspective the most evil part of my computer is 
the harddrive, because it has three bad properties;

-- its slowing stuff down
-- its very noisy
-- its sucks my battery dry (on laptops)

I dont care as much about how fast or efficient the swapping system 
really is, what does annoy me is when it lets me down. Say I do some 
action repeatedly every once in a while and it always takes about X 
milliseconds, when after a while that same action takes 2*X 
milliseconds. Now I'm DISAPPOINTED and I got a grudge with kswapd.

Its *emotionally* more 'okay' for the harddrive to its thing when I 
initiate it through some action (launching program, copying files) 
because then I expect it.

 From what I've read previously in this thread, it seems to me that the 
only major problem with swapping that not all users want file system 
cache to swap out actual applications (thus making that somewhat aged 
mozilla window abit laggy).

Maybe we could just have a "Allow file system cache to swap out 
applications checkbox somewhere"?

Or, Am I missing something?




Sincerly,
/m

jlnance@unity.ncsu.edu wrote:
> On Tue, Jun 01, 2004 at 02:57:00PM +0300, Lenar L?hmus wrote:
> 
>>jlnance@unity.ncsu.edu wrote:
>>
>>
>>>I'm not sure.  Copying a file is a pretty good indication that you
>>>are about to do something with either the new or the old file.
>>>
>>
>>Like taking the new file with me on USB dongle and deleting old one? 
>>Caching the file really doesn't help in this case.
> 
> 
> No, it does not help in this case.
> 
> Not putting things in cache is a solution for the problem of
> having useful stuff pushed out of the cache.  However, fixing
> the problem this way may create other problems if it causes
> us to fail to put useful things into the cache.
> 
> The point I was trying (perhaps unsuccessfully) to make, is
> that we should be careful about not caching things.  We are
> likely to break other corner cases by fixing the ones we
> are discussing.
> 
> Thanks,
> 
> Jim
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
