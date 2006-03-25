Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbWCYFhw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWCYFhw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 00:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbWCYFhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 00:37:51 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:55145 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751024AbWCYFhv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 00:37:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Ftr/AcjEmBW90vwXF0roJTzjDmUxasB3A8OdSl3vuaREQjJK2Ffw94EBlBwulhoTwPz+EXXX7wEqhAsqD9htv29F8ogbXZiBS81E4YFYtNedHkC6n1MxzNe2Y8EhLx9Yia5PewsRtX039TdgQhr1+nDp0Wo+WkLIQMwxc10vrTY=
Message-ID: <4424D729.6040602@gmail.com>
Date: Sat, 25 Mar 2006 13:37:45 +0800
From: Yi Yang <yang.y.yi@gmail.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, johnpol@2ka.mipt.ru, matthltc@us.ibm.com
Subject: Re: Connector: Filesystem Events Connector v3
References: <4423673C.7000008@gmail.com>	 <1143183541.2882.7.camel@laptopd505.fenrus.org>	 <20060323.230649.11516073.davem@davemloft.net>	 <4c4443230603240614m5f495340y9dc6ccc45e1e45b4@mail.gmail.com> <1143210312.2882.72.camel@laptopd505.fenrus.org>
In-Reply-To: <1143210312.2882.72.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven Ð´µÀ:
> On Fri, 2006-03-24 at 22:14 +0800, yang.y.yi@gmail.com wrote:
>   
>> On 3/24/06, David S. Miller <davem@davemloft.net> wrote:
>>     
>>> From: Arjan van de Ven <arjan@infradead.org>
>>> Date: Fri, 24 Mar 2006 07:59:01 +0100
>>>
>>>       
>>>> then make the syslog part optional.. if it's not already!
>>>>         
>>> Regardless I still think the filesystem events connector is a useful
>>> facility.
>>>
>>> Audit just has way too much crap in it, and it's so much nicer to have
>>> tiny modules that are optimized for specific areas of activity over
>>> something like audit that tries to do everything.
>>>
>>>       
>> the filesystem events connector is small and has low overhead, it only
>> focuses on
>>  activities in the filesystem
>>     
>
> ... so much that it's not useful for antivirus at least.
> And your claim that audit has big overhead.. can you substantiate that?
> I mean, this code has big overhead too in principle, the biggest
> bottleneck is the sending-to-userspace, and that's the same in both.
>   
sending to userspace is common for audit and the filesystem events
connector,
audit has many branches to process before sending audit result, it is
real big
overhead.
>
>
>   

