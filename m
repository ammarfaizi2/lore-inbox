Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264266AbUD0Sbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264266AbUD0Sbl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 14:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264274AbUD0Sbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 14:31:41 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:62349 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S264266AbUD0SaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 14:30:16 -0400
Message-ID: <408EA6AB.90508@nortelnetworks.com>
Date: Tue, 27 Apr 2004 14:30:03 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc Boucher <marc@linuxant.com>
CC: Adam Jaskiewicz <ajjaskie@mtu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
References: <20040427165819.GA23961@valve.mbsi.ca> <408E9771.7020302@mtu.edu> <F55B44BB-9870-11D8-85DF-000A95BCAC26@linuxant.com> <408E9C59.2090502@nortelnetworks.com> <1DCA0B77-9876-11D8-85DF-000A95BCAC26@linuxant.com>
In-Reply-To: <1DCA0B77-9876-11D8-85DF-000A95BCAC26@linuxant.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Boucher wrote:
> 
> 
> On Apr 27, 2004, at 1:46 PM, Chris Friesen wrote:

>> Does your company honestly feel that misleading the module loading 
>> tools is actually the proper way to work around the issue of 
>> repetitive warning messages?  This is blatently misleading and does 
>> not reflect well, especially when the "GPL" directory mentioned in the 
>> source string is actually empty.
> 
> 
> It is a purely technical workaround. There is nothing misleading to the 
> human eye,

modinfo reports a GPL license, and the kernel does not report itself as tainted.  That's misleading.

> and the GPL directory isn't empty; it is included in full in our generic 
> .tar.gz, rpm and
> .deb packages.

My apologies.  I was going on the word of the original poster.

Chris
