Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVAaLvC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVAaLvC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 06:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVAaLvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 06:51:01 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:12452 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261158AbVAaLuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 06:50:44 -0500
From: Benno <benjl@cse.unsw.edu.au>
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
Date: Mon, 31 Jan 2005 22:50:35 +1100
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: My System doesn't use swap!
Message-ID: <20050131115034.GA9571@cse.unsw.edu.au>
References: <41FE1B4B.2060305@tiscali.de> <200501311157.10932.mbuesch@freenet.de> <41FE2814.9030503@tiscali.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41FE2814.9030503@tiscali.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Jan 31, 2005 at 13:44:04 +0100, Matthias-Christian Ott wrote:
>Michael Buesch wrote:
>
>>Quoting Matthias-Christian Ott <matthias.christian@tiscali.de>:
>> 
>>
>>>Hi!
>>>I have mysterious Problem:
>>>90 % of my Ram are used (340 MB), but 0 Byte of my Swap (2GB) is used 
>>>and about about 150 MB are swappable.
>>>
>>>[matthias-christian@iceowl ~]$ free
>>>            total       used       free     shared    buffers     cached
>>>Mem:        383868     362176      21692          0         12     208956
>>>-/+ buffers/cache:     153208     230660
>>>   
>>>
>>                                   ^^^^^^
>>You have ~230M of 380M free.
>>Nothing mysterious here.
>>
>>
>Ok maybe I wasn't able to read the /free/ output correctly, but why is 
>no swap used (more than 60% ram are used)?

Why would you want to use swap when you still have free RAM? The kernel
isn't using swap because there is no need to.

Benno
