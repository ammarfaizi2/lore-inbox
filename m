Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264334AbUD0UgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264334AbUD0UgY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 16:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264340AbUD0UgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 16:36:24 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:55046 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S264334AbUD0UgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 16:36:22 -0400
Message-ID: <408EC538.5090603@techsource.com>
Date: Tue, 27 Apr 2004 16:40:24 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
CC: Marc Boucher <marc@linuxant.com>, Adam Jaskiewicz <ajjaskie@mtu.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
References: <20040427165819.GA23961@valve.mbsi.ca> <408E9771.7020302@mtu.edu> <F55B44BB-9870-11D8-85DF-000A95BCAC26@linuxant.com> <408E9C59.2090502@nortelnetworks.com> <1DCA0B77-9876-11D8-85DF-000A95BCAC26@linuxant.com> <408EA6AB.90508@nortelnetworks.com>
In-Reply-To: <408EA6AB.90508@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Chris Friesen wrote:
> Marc Boucher wrote:
> 
>>
>>
>> On Apr 27, 2004, at 1:46 PM, Chris Friesen wrote:
> 
> 
>>> Does your company honestly feel that misleading the module loading 
>>> tools is actually the proper way to work around the issue of 
>>> repetitive warning messages?  This is blatently misleading and does 
>>> not reflect well, especially when the "GPL" directory mentioned in 
>>> the source string is actually empty.
>>
>>
>>
>> It is a purely technical workaround. There is nothing misleading to 
>> the human eye,
> 
> 
> modinfo reports a GPL license, and the kernel does not report itself as 
> tainted.  That's misleading.
> 
>> and the GPL directory isn't empty; it is included in full in our 
>> generic .tar.gz, rpm and
>> .deb packages.
> 
> 
> My apologies.  I was going on the word of the original poster.


Even that is a violation of the GPL.  You can't link closed-source code 
with GPL code and release it legally.

Binary-only modules are technically a violation of the GPL, but kernel 
developers have chosen to allow it under tight constraints.

But the building and releasing ANYTHING which is made up of GPL code and 
closed-source code and released as an atomic unit (not merely agregated 
on the same medium) is illegal.

