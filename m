Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264226AbUD0Rds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264226AbUD0Rds (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 13:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264238AbUD0Rds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 13:33:48 -0400
Received: from wirefire.bureaudepost.com ([66.38.187.209]:56999 "EHLO
	oasis.linuxant.com") by vger.kernel.org with ESMTP id S264226AbUD0RdU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 13:33:20 -0400
In-Reply-To: <408E9771.7020302@mtu.edu>
References: <20040427165819.GA23961@valve.mbsi.ca> <408E9771.7020302@mtu.edu>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <F55B44BB-9870-11D8-85DF-000A95BCAC26@linuxant.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Marc Boucher <marc@linuxant.com>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Date: Tue, 27 Apr 2004 13:33:12 -0400
To: Adam Jaskiewicz <ajjaskie@mtu.edu>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Adam,

On Apr 27, 2004, at 1:25 PM, Adam Jaskiewicz wrote:

>
>> Actually, we also have no desire nor purpose to prevent tainting. The 
>> purpose
>> of the workaround is to avoid repetitive warning messages generated 
>> when
>> multiple modules belonging to a single logical "driver"  are loaded 
>> (even when
>> a module is only probed but not used due to the hardware not being 
>> present).
>> Although the issue may sound trivial/harmless to people on the lkml, 
>> it was a
>> frequent cause of confusion for the average person.
>>
> Would it not be better to simply place a notice in the readme 
> explaining what
> the error messages mean, rather than working around the liscense 
> checking
> code? Educate the users, rather than fibbing.

Good idea. We will try to clarify the matter in the docs for the next 
release.
A lot of users don't read them though, so a proper fix remains 
necessary..

Regards
Marc

--
Marc Boucher
President
Linuxant inc.
http://www.linuxant.com


>
> --
> Adam Jaskiewicz
>

