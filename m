Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262931AbUD2Crw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbUD2Crw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 22:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbUD2Crw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 22:47:52 -0400
Received: from ptb-relay03.plus.net ([212.159.14.214]:28939 "EHLO
	ptb-relay03.plus.net") by vger.kernel.org with ESMTP
	id S262931AbUD2Crs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 22:47:48 -0400
Message-ID: <40906CC3.9090203@mauve.plus.com>
Date: Thu, 29 Apr 2004 03:47:31 +0100
From: Ian Stirling <ian.stirling@mauve.plus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Marc Boucher <marc@linuxant.com>, Timothy Miller <miller@techsource.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
References: <Pine.LNX.4.44.0404282237430.19633-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0404282237430.19633-100000@chimarrao.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Thu, 29 Apr 2004, Ian Stirling wrote:
> 
> 
>>>Your new proposed message sounds much clearer to the ordinary mortal and 
>>>would imho be a significant improvement. Perhaps printing repetitive 
>>>warnings for identical $MODULE_VENDOR strings could also be avoided, 
>>>taking care of the redundancy/volume problem as well..
>>
>>Is this worth 100 or 200 bytes of code though?
>>I'd have to say no.
> 
> 
> I suspect it'll be worth it.  If only because it'll save
> the kernel community from people asking things like:
> 
> "help, my kernel is tainted! what does it mean and how can I fix it?"

Sorry.
I meant adding code to suppress warnings, not the expanded warning, which is sensible.
