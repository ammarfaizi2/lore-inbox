Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263315AbTEIRZf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 13:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263348AbTEIRZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 13:25:34 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:35799 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263315AbTEIRZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 13:25:33 -0400
Message-ID: <3EBBE77D.3020105@nortelnetworks.com>
Date: Fri, 09 May 2003 13:38:05 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: how to measure scheduler latency on powerpc?  realfeel doesn't work due to /dev/rtc issues
References: <Pine.LNX.4.50.0305081735040.2094-100000@blue1.dev.mcafeelabs.com> <20030509003825.GR8978@holomorphy.com> <Pine.LNX.4.53.0305082052160.21290@chaos> <3EBB25FD.7060809@nortelnetworks.com> <20030509042659.GS8978@holomorphy.com> <3EBB4735.30701@nortelnetworks.com> <20030509062008.GT8978@holomorphy.com> <3EBB504C.1030001@nortelnetworks.com> <20030509070142.GU8978@holomorphy.com> <1052498824.867.8.camel@icbm> <20030509165359.GX8978@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well, since time was short I didn't want to hack the kernel. What I ended up
doing was setting up an itimer for 10ms intervals and then measuring how much
longer than 10ms I was asleep for.  While this only collects samples at 100Hz,
it will work with the default kernel.

Thanks for the suggestions,

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

