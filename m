Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264313AbTLYPKr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 10:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264314AbTLYPKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 10:10:47 -0500
Received: from smithers.nildram.co.uk ([195.112.4.54]:36370 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S264313AbTLYPKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 10:10:45 -0500
Message-ID: <3FEAFDF3.80008@amberdata.demon.co.uk>
Date: Thu, 25 Dec 2003 15:10:43 +0000
From: David Monro <davidm@amberdata.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Subject: Re: handling an oddball PS/2 keyboard
References: <3FEA5044.5090106@amberdata.demon.co.uk> <20031225063936.GA15560@win.tue.nl> <200312251316.hBPDG7LT000163@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200312251316.hBPDG7LT000163@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
>>I suppose Vojtech will have no objections to using this ID
>>to skip the tests for e0 and e1 as protocol (escape) scancodes.
> 
> 
> There might be no need for such a workaround - a lot of PS/2 devices
> which were not intended for PCs work fine in set 3, particularly if
> the device they were intended to work with uses set 3 natively, where
> this conflict with protocol scancodes problem doesn't exist.  If the
> keyboard works in set 3, add 0xab85 to the list of keyboards to force
> set 3 for, (and maybe also add the ID for my keyboard while we're at
> it :-) ).

I will definitely explore this possibility. Whats the ID of your 
keyboard? (and what is it?)

Cheers,

	David

> 
> John.


