Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264247AbUD0SQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264247AbUD0SQX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 14:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264273AbUD0SNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 14:13:05 -0400
Received: from wirefire.bureaudepost.com ([66.38.187.209]:21933 "EHLO
	oasis.linuxant.com") by vger.kernel.org with ESMTP id S264263AbUD0SKL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 14:10:11 -0400
In-Reply-To: <408E9C59.2090502@nortelnetworks.com>
References: <20040427165819.GA23961@valve.mbsi.ca> <408E9771.7020302@mtu.edu> <F55B44BB-9870-11D8-85DF-000A95BCAC26@linuxant.com> <408E9C59.2090502@nortelnetworks.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1DCA0B77-9876-11D8-85DF-000A95BCAC26@linuxant.com>
Content-Transfer-Encoding: 7bit
Cc: Adam Jaskiewicz <ajjaskie@mtu.edu>, linux-kernel@vger.kernel.org
From: Marc Boucher <marc@linuxant.com>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Date: Tue, 27 Apr 2004 14:10:08 -0400
To: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Apr 27, 2004, at 1:46 PM, Chris Friesen wrote:

> Marc Boucher wrote:
>
>> On Apr 27, 2004, at 1:25 PM, Adam Jaskiewicz wrote:
>
>>> Would it not be better to simply place a notice in the readme 
>>> explaining what
>>> the error messages mean, rather than working around the liscense 
>>> checking
>>> code? Educate the users, rather than fibbing.
>> Good idea. We will try to clarify the matter in the docs for the next 
>> release.
>> A lot of users don't read them though, so a proper fix remains 
>> necessary..
>
> Does your company honestly feel that misleading the module loading 
> tools is actually the proper way to work around the issue of 
> repetitive warning messages?  This is blatently misleading and does 
> not reflect well, especially when the "GPL" directory mentioned in the 
> source string is actually empty.

It is a purely technical workaround. There is nothing misleading to the 
human eye,
and the GPL directory isn't empty; it is included in full in our 
generic .tar.gz, rpm and
.deb packages.

Marc

--
Marc Boucher
President
Linuxant inc.
http://www.linuxant.com

