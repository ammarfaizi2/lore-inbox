Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264436AbTDPQDl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 12:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264451AbTDPQDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 12:03:41 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:57568 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S264436AbTDPQDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 12:03:33 -0400
Message-ID: <3E9D8062.1060202@nortelnetworks.com>
Date: Wed, 16 Apr 2003 12:10:10 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Brien <admin@brien.com>
Cc: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org
Subject: Re: my dual channel DDR 400 RAM won't work on any linux distro
References: <200304161511.h3GFBoe7000614@81-2-122-30.bradfords.org.uk> <003801c3042e$a6bcbea0$6901a8c0@athialsinp4oc1>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brien wrote:

> I ran Memtest86, and there're 290 errors that showed up from test 7. But the
> thing that I don't understand is, if I use either of the RAM modules alone,
> Linux loads and runs perfectly for as long as I've tried; Could it possibly
> be a problem with something besides the RAM (e.g. motherboard, CPU)? And I
> still don't know if my RAM setup is even supported by Linux -- I'm guessing
> that it is though (?).

Memory support is generally not something handled by the OS.

The more RAM modules you've got, the more reactance on the bus to memory. It may 
be that the second module is loading down the bus enough that the mobo can't 
keep up with the timings.  Try easing off a bit on the memory timings and/or 
strengthening the memory drive strength.

Linux often shows up memory problems when M$ doesn't since it is a) more 
aggressive in its use of memory, and b) capable of driving cpu and chipset 
closer to their theoretical limits.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

