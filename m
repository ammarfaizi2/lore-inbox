Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263661AbTJ0VNl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 16:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263666AbTJ0VNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 16:13:41 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:32731 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S263661AbTJ0VNi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 16:13:38 -0500
Message-ID: <3F9D8BDE.70406@pacbell.net>
Date: Mon, 27 Oct 2003 13:19:26 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Johannes Erdfelt <johannes@erdfelt.com>
CC: Patrick Mochel <mochel@osdl.org>, ian.soboroff@nist.gov,
       linux-kernel@vger.kernel.org
Subject: Re: APM suspend still broken in -test9
References: <Pine.LNX.4.44.0310271219040.13116-100000@cherise> <3F9D84BA.7070904@pacbell.net> <20031027155334.B21342@sventech.com>
In-Reply-To: <20031027155334.B21342@sventech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>>BTW, can you help with any of the uhci-hcd suspend/resume issues? I do not 
>>>know the code well enough to track it down.. 
>>
>>I'm trying to avoid that; sorry!  Some of them could be related to UHCI
>>patches that are waiting for feedback/approval from Johannes.
> 
> 
> Which patches do you suspect are related? It's hard for me to test
> anything suspend/resume related with UHCI since I don't have any systems
> with a UHCI controller that would be affected.

Clearly not the "don't modify toggles in control queues" patch!

But I remember some patches related to quiescing endpoints,
unlinking, shutdown, and so on.

- Dave


> However, I can (well, I should have already...) eyeball the patches
> atleast.
> 
> JE
> 

