Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267748AbUJLUlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267748AbUJLUlo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 16:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267759AbUJLUlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 16:41:44 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:8836 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S267748AbUJLUlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 16:41:42 -0400
Message-ID: <416C4173.3060408@nortelnetworks.com>
Date: Tue, 12 Oct 2004 14:41:23 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: Andries Brouwer <aebr@win.tue.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       wli@holomorphy.com
Subject: Re: [BUG]  oom killer not triggering in 2.6.9-rc3  -- FIXED in -rc4
References: <41672D4A.4090200@nortelnetworks.com> <1097503078.31290.23.camel@localhost.localdomain> <416B6594.5080002@nortelnetworks.com> <20041012094439.GA3223@pclin040.win.tue.nl> <416BF927.7000000@nortelnetworks.com> <20041012130859.G2441@build.pdx.osdl.net>
In-Reply-To: <20041012130859.G2441@build.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:

> Chris, did you try the patch I sent you (it's in mainline now, so if you
> re-test on 2.6.9-rc4 you'd pick it up)?  

Oops.  No I didn't--meant to, but then forgot.  I should have, it seems to be 
fixed in -rc4.

 > With that patch, with 2G of
> memory and no swap, my machine did not lock up, and the conditions that
> the patch protect against were triggered.  And, with the patch backed
> out, kswapd spins out of control.  I believe this is fixed.

2.6.9-rc4 seems sane again.  Start up two memory hogs, one gets killed immediately.

Sweet.

Thanks for your help,

Chris
