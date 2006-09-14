Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWINVVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWINVVd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWINVVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:21:32 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:33544 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751185AbWINVVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:21:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=mWwOUGzrr+3XD/+EfvNavRtPs0ornbUg5k9nVDurDgCRnOFlbai5M4OVYQiamZ88NlheuCsTtvycjT/N07KiizdG5MdSwV/UC/iYYzt+m6aCRnaZC5sqa+TxKLTD6zADTTscUSDIsGnNXlkXsz5FzSl3olhMN6WyrGAbNzsuQzg=
Message-ID: <4509C7D0.8080108@gmail.com>
Date: Thu, 14 Sep 2006 23:20:57 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Jim Cromie <jim.cromie@gmail.com>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC patch] MAINTAINERS:  encourage testers to volunteer
References: <4509AA10.4050907@gmail.com> <20060914194411.GA669@stusta.de>
In-Reply-To: <20060914194411.GA669@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Thu, Sep 14, 2006 at 01:14:24PM -0600, Jim Cromie wrote:
>> Add a new entry-type into MAINTAINERS whereby folks with hardware can 
>> volunteer to
>> test patches to the driver.  It should encourage folks to put themselves 
>> "on the hook"
>> in trade for a little bit of notoriety.
>>
>> Hopefully this will help improve:
>> - support for rare hardware
>> - QA on that hardware
>> - connections between hackers & testers
>> - would-be hackers can find new things to do, esp in less visited parts 
>> of the dist.
>>
>> Additions should be approved by maintainers etc, but thats no different 
>> than is currently done.
> 
> There are currently 97 different saa7134 card types supported by the 
> kernel. Do we need an entry for each of them (each card type has it's 
> own specific support)?

It's utterly sufficient to know about only one person, who have that piece of 
hardware in most cases -- to test the core of the driver, not all specific 
parts. Something like to test it at least roughly.

> And this information will become outdated much faster than updated
> (even the maintainers entries are sometimes outdated).

When akpm proposed this, I agreed (but still have no contacts to post a patch), 
because I needed somebody to test a driver I had rewritten a little bit, but 
there was no place to take a look...
But his thoughts were a little bit different, he considered creating a separate 
file named TESTERS and there have a list of these "qa people" (even for one 
specific piece of hw if necessary). [I hope I did understand him correctly...]

>> --- doc-touches/MAINTAINERS~	2006-09-14 11:50:03.000000000 -0600
>> +++ doc-touches/MAINTAINERS	2006-09-14 12:19:13.000000000 -0600
>> @@ -80,6 +80,12 @@
>> 			it has been replaced by a better system and you
>> 			should be using that.
>>
>> +V: Validation/Test contact and hardware they can test.
>> +
>> +	Identifies folks who are willing to test driver patches, etc.
>> +	Also can identify lack of hardware for otherwize maintained drivers
>> +	by using 'none'
>> +
>> 3C359 NETWORK DRIVER
>> P:	Mike Phillips
>> M:	mikep@linuxtr.net

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
