Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264213AbUD0RqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264213AbUD0RqO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 13:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264222AbUD0RqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 13:46:13 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:39566 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S264213AbUD0RqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 13:46:09 -0400
Message-ID: <408E9C59.2090502@nortelnetworks.com>
Date: Tue, 27 Apr 2004 13:46:01 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc Boucher <marc@linuxant.com>
CC: Adam Jaskiewicz <ajjaskie@mtu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
References: <20040427165819.GA23961@valve.mbsi.ca> <408E9771.7020302@mtu.edu> <F55B44BB-9870-11D8-85DF-000A95BCAC26@linuxant.com>
In-Reply-To: <F55B44BB-9870-11D8-85DF-000A95BCAC26@linuxant.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Boucher wrote:

> On Apr 27, 2004, at 1:25 PM, Adam Jaskiewicz wrote:

>> Would it not be better to simply place a notice in the readme 
>> explaining what
>> the error messages mean, rather than working around the liscense checking
>> code? Educate the users, rather than fibbing.
> 
> 
> Good idea. We will try to clarify the matter in the docs for the next 
> release.
> A lot of users don't read them though, so a proper fix remains necessary..

Does your company honestly feel that misleading the module loading tools is actually the proper way 
to work around the issue of repetitive warning messages?  This is blatently misleading and does not 
reflect well, especially when the "GPL" directory mentioned in the source string is actually empty.

A "proper fix" begins with not attempting to mislead the kernel/tools about the license...

Chris

