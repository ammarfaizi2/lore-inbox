Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317059AbSFKOP5>; Tue, 11 Jun 2002 10:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317063AbSFKOP4>; Tue, 11 Jun 2002 10:15:56 -0400
Received: from ip68-9-71-221.ri.ri.cox.net ([68.9.71.221]:44886 "EHLO
	mail.blue-labs.org") by vger.kernel.org with ESMTP
	id <S317059AbSFKOPz>; Tue, 11 Jun 2002 10:15:55 -0400
Message-ID: <3D060602.20409@blue-labs.org>
Date: Tue, 11 Jun 2002 10:15:30 -0400
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0+) Gecko/20020501
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Thunder from the hill <thunder@ngforever.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-pre10-ac2, compile warnings/failures
In-Reply-To: <3D0518BF.4090404@blue-labs.org> <Pine.LNX.4.44.0206101855290.17269-100000@hawkeye.luckynet.adm> <20020611060353.GA6711@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Bmilter: Processing completed, Bmilter version 0.1.0 build 565; timestamp 2002-06-11 10:15:19, message serial number 7922
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's been brought up over and over the last couple of years.  GCC 
started warning about it quite a while ago and it's been named as a bad 
form.  Patches to fix various things have been submitted sporadically 
for a long time as well.  Future versions of GCC will mark it as an error.

David

Greg KH wrote:

>On Mon, Jun 10, 2002 at 06:59:36PM -0600, Thunder from the hill wrote:
>  
>
>>Hi,
>>
>>On Mon, 10 Jun 2002, David Ford wrote:
>>    
>>
>>>People, please don't do things like:
>>>
>>>[bad use of doublequotes]
>>>
>>>Patches keep going in to fix this.
>>>
>>>[good use of doublequotes]
>>>      
>>>
>>The same applies to 2.5. Can someone write a perl script that treats it so 
>>anonymous that it can find these buggy places?
>>    
>>
>
>And could someone actually _tell_ the maintainers of these drivers that
>there is a problem?  And what compiler version causes it?
>
>This the first I've heard of this problem.
>
>greg k-h
>  
>

