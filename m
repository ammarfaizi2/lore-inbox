Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268620AbTCCSDT>; Mon, 3 Mar 2003 13:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268670AbTCCSDT>; Mon, 3 Mar 2003 13:03:19 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:18397 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S268620AbTCCSDS>; Mon, 3 Mar 2003 13:03:18 -0500
Message-ID: <3E639AD3.7010502@nortelnetworks.com>
Date: Mon, 03 Mar 2003 13:11:31 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jeff Dike <jdike@karaya.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Michael Richardson <mcr@sandelman.ottawa.on.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: anyone ever done multicast AF_UNIX sockets?
References: <200303030100.h23102L07592@uml.karaya.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike wrote:

> Well, that problem is actually that lo and dummy interfaces don't support
> multicast.  You need something like an eth device for multicast, even if you're
> nowhere near a LAN.

My main gripe was that I had turned *OFF* multicast on the eth 
interface, but pinging 224.0.0.1 still went out over the network and I 
got all the responses.

Currently I really want to do multicast only on the local box, and I 
don't want the packets going out over the network.  This is where the 
multicast unix sockets came from.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

