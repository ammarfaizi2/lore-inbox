Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261754AbULJQDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbULJQDv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 11:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbULJQC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 11:02:27 -0500
Received: from ms-smtp-01-qfe0.socal.rr.com ([66.75.162.133]:49347 "EHLO
	ms-smtp-01-eri0.socal.rr.com") by vger.kernel.org with ESMTP
	id S261750AbULJPre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 10:47:34 -0500
Message-ID: <41B9C512.1010908@clones.net>
Date: Fri, 10 Dec 2004 07:47:30 -0800
From: Glendon Gross <gross@clones.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Dittmer <jdittmer@ppp0.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Burning CD's and 2.6.9
References: <Pine.NEB.4.44.0412090810570.27084-100000@bsd.clones.net> <41B88007.7060300@ppp0.net> <41B91D62.20804@clones.net> <41B950E5.3080806@ppp0.net> <41B97A81.50606@clones.net> <41B98054.8080002@ppp0.net>
In-Reply-To: <41B98054.8080002@ppp0.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just successfully made a data DVD using 2.6.9 and growisofs.   So I 
know that the lockups I had experienced were either a fluke or due
to problems with cdrecord. 

I think you are right, that growisofs calls mkosifs which cannot make 
audio CD's.  So at least I know this is not a driver issue.  Most likely 
the
problems I have been having were due to cdrecord. 

Regards,

Glendon Gross


Jan Dittmer wrote:

> Glendon Gross schrieb:
>
>> I've been using growisofs for quite some time now, but I haven't yet 
>> tested it under 2.6.9. Is it possible to make audio CD's with 
>> growisofs?  If it is, then I really don't need cdrecord at all.
>
>
> Sorry didn't test it. But I think the answer is no, as it just
> calls mkisofs to get an iso which in turn is not capable of creating
> audio cds?
>
> Jan
>
>>
>> Thanks  for your input.
>>
>> Regards,
>>
>> Glendon Gross
>>
>>
>> Jan Dittmer wrote:
>>
>>> Glendon Gross wrote:
>>>  
>>>
>>>> When I initially posted the problem, I had no /dev/hdc device but 
>>>> now I have cleared that up by commenting out
>>>> the "append hdc=ide-scsi" line in /etc/lilo.conf.   I still need to 
>>>> do more testing to determine the cause of the lockups
>>>> I have been getting when trying to burn CD's under 2.6.9 with 
>>>> cdrecord.  I may be using the wrong version of
>>>> cdrecord, but I noticed that the syntax   "cdrecord dev=/dev/hdc" 
>>>> does work, and is able to talk to the DVD writer.
>>>>   
>>>
>>>
>>>
>>> You should also try growisofs from the dvd+rw-tools package. It works
>>> great for me burning dvds.
>>>
>>> Jan
>>>
>>>
>>>  
>>>
>
>
>
>

