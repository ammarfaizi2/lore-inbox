Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbTIZRXn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 13:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbTIZRXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 13:23:43 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:26336 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261538AbTIZRXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 13:23:41 -0400
Message-ID: <3F7475F2.3040207@nortelnetworks.com>
Date: Fri, 26 Sep 2003 13:22:58 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
References: <A2yd.64p.31@gated-at.bofh.it> <A2yd.64p.29@gated-at.bofh.it>	<A317.6GH.7@gated-at.bofh.it> <m37k3viiqp.fsf@averell.firstfloor.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> The solution proposed by Ivan sounds much better. The basic problem
> is that the Ethernet header is not a multiple of 4 and that misaligns
> everything after it.

At least some hardware will offset the incoming packet by two bytes to 
align everything.  Whatever mechanism we end up using, it would be nice 
if it could make use of the hardware that is capable of this.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

