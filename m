Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262602AbVAPTsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262602AbVAPTsi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 14:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbVAPTps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 14:45:48 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:44713 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S262593AbVAPTnt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 14:43:49 -0500
Message-ID: <41EAC3FD.1070001@drzeus.cx>
Date: Sun, 16 Jan 2005 20:43:57 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ian Molton <spyro@f2s.com>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       Richard Purdie <rpurdie@rpsys.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: MMC Driver RFC
References: <021901c4f8eb$1e9cc4d0$0f01a8c0@max> <20050112214345.D17131@flint.arm.linux.org.uk> <023c01c4f8f3$1d497030$0f01a8c0@max> <20050112221753.F17131@flint.arm.linux.org.uk> <41E5B177.4060307@f2s.com> <41E7AF11.6030005@drzeus.cx> <41E7DD5E.5070901@f2s.com> <41EA5C8D.8070407@drzeus.cx> <41EA69F0.5060500@f2s.com>
In-Reply-To: <41EA69F0.5060500@f2s.com>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Molton wrote:

>>> The toshiba controller appears to want to be told when an ACMD is 
>>> issued, compared to a normal CMD.
>>
>> Seems very strange since there's no change in what goes over the wire.
>
> I think the controller (for some odd reason) keeps some extra internal 
> state.

Have you tried using it without telling the controller that it's an ACMD 
being sent?

Rgds
Pierre
