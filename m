Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbUCDSGM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 13:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbUCDSGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 13:06:12 -0500
Received: from smtp-roam.Stanford.EDU ([171.64.14.91]:54938 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S262052AbUCDSGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 13:06:07 -0500
Message-ID: <40477003.4030408@myrealbox.com>
Date: Thu, 04 Mar 2004 10:05:55 -0800
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paulo Marques <pmarques@grupopie.com>
CC: Andy Lutomirski <amluto@hotmail.com>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB update for 2.6.3
References: <fa.ck6rcsq.nl8r18@ifi.uio.no> <fa.eul0v67.1p62arn@ifi.uio.no>
In-Reply-To: <fa.eul0v67.1p62arn@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paulo Marques wrote:

> Andy Lutomirski wrote:
> 
>> Greg KH wrote:
>>
>>>
>>> Paulo Marques:
>>>   o USB: fix usblp.c
>>>
>>
>> Unless I'm missing something, this won't fix the usblp_write spinning 
>> bug I hit.  If it helps, I can try to reproduce it with some debugging 
>> code attached.
>>
> 
> 

I added some printks to usblp_write on 2.6.1 vanilla and I couldn't reproduce 
the bug (even without your patch).  So, unless I can trigger it again, I won't 
worry about it.

Thanks.

--Andy
