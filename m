Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268228AbUJDQYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268228AbUJDQYx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 12:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268095AbUJDQYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 12:24:53 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.83]:61920 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S268053AbUJDQYc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 12:24:32 -0400
Date: Mon, 4 Oct 2004 12:24:30 -0400 (EDT)
From: William Knop <wknop@andrew.cmu.edu>
To: Mark Lord <lkml@rtr.ca>
cc: Jon Lewis <jlewis@lewis.org>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: libata badness
In-Reply-To: <4161750A.6060200@rtr.ca>
Message-ID: <Pine.LNX.4.60-041.0410041217270.9105@unix43.andrew.cmu.edu>
References: <Pine.LNX.4.60-041.0410040656001.2350@unix48.andrew.cmu.edu>
 <Pine.LNX.4.58.0410040953160.26615@web1.mmaero.com>
 <Pine.LNX.4.60-041.0410041132070.9105@unix43.andrew.cmu.edu> <4161750A.6060200@rtr.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Great. I'll give that a shot after I drive checker utility finishes.

However it seems like the kernel shouldn't be oopsing, panicking, or 
double faulting if the drive is questionable. It apparently blew away my 
root fs last time. A peripheral drive failure shouldn't cause such 
destruction across the system, no?

On Mon, 4 Oct 2004, Mark Lord wrote:

> I have used Maxtor "SATA" drives that require
> the O/S to do a "SET FEATURES :: UDMA_MODE" command
> on them before they will operate reliably.
> This despite the SATA spec stating clearly that
> such a command should/will have no effect.
>
> I suppose libata does this already, but just in case not..
> Something simple to check up on.
> -- 
> Mark Lord
> (hdparm keeper & the original "Linux IDE Guy")
>
> William Knop wrote:
>> 
>> Ah, well all of them are Maxtor drives... One 6y250m0 and three 7y250m0 
>> drives. I'm using powermax on them right now. They all passed the quick 
>> test, and the full test results are forthcoming.
>
>
