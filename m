Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262636AbVAKCfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262636AbVAKCfo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 21:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbVAKCfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 21:35:19 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:63175 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S262610AbVAJVVA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 16:21:00 -0500
Message-ID: <41E2F1BD.1020407@drzeus.cx>
Date: Mon, 10 Jan 2005 22:21:01 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       stephen_pollei@comcast.net, rmk+lkml@arm.linux.org.uk
Subject: Re: [2.6 patch] remove SPF-using wbsd lists from MAINTAINERS
References: <20050110184307.GB2903@stusta.de> <1105382033.12054.90.camel@localhost.localdomain>
In-Reply-To: <1105382033.12054.90.camel@localhost.localdomain>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Llu, 2005-01-10 at 18:43, Adrian Bunk wrote:
> 
>>IMHO lists rejecting emails based on some non-standard extension don't 
>>belong into MAINTAINERS.
> 
> 
> Find out why someone is publishing records saying your mail isnt valid
> instead of moaning here. If they are using SPF and you are not using any
> strange extensions its fine. You or your provider appears to be
> advertising that stusta.de doesn't use the mail relay you are using.
> 

I think I've fixed the problem now. It wasn't that there were published 
records for stusta.de, the problem was that the mail server couldn't 
resolve your domain. For some reason everything from the DNS I'm using 
to your DNS gets dropped. The mail server takes the paranoid route and 
assumes the worst when it cannot contact dns servers (that's why you got 
a 4xx, not a 5xx). I've now changed DNS which will hopefully solve the 
issue.

As for dropping the mailing list out of MAINTAINERS then I'd prefer you 
didn't (of course). But I will not remove the filters on the servers 
since they remove a lot of spam. If that means it cannot be in 
MAINTAINERS, then so be it.

Rgds
Pierre
