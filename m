Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbUCEAoM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 19:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262137AbUCEAoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 19:44:12 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:62353 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262108AbUCEAoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 19:44:10 -0500
Message-ID: <4047CD56.5000700@nortelnetworks.com>
Date: Thu, 04 Mar 2004 19:44:06 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Tom Rini <trini@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: problem with cache flush routine for G5?
References: <40479A50.9090605@nortelnetworks.com>	 <1078444268.5698.27.camel@gaston>	 <20040304235754.GK26065@smtp.west.cox.net> <1078445065.5703.37.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
>>... unless this is a 'G5' that's not in a pmac, it's not my code, and
>>the openfirmware bootloaders don't, IIRC, do any cache stuff.
>>
> 
> Heh, well, they should. 

Actually I think they do.  chrpmain.c and coffmain.c both reference 
flush_cache() in misc.S in arch/ppc/boot/pmac.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

