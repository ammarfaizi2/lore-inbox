Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264110AbTJOUxw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 16:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264111AbTJOUxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 16:53:52 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:17319 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S264110AbTJOUxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 16:53:51 -0400
Message-ID: <3F8DB3D8.3050406@nortelnetworks.com>
Date: Wed, 15 Oct 2003 16:53:44 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Christopher Friesen" <cfriesen@nortelnetworks.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, arr@watson.org,
       skraw@ithnet.com, lkml@lpbproductions.com
Subject: Re: question on incoming packets and scheduler
References: <3F8CA55C.1080203@nortelnetworks.com> <Pine.LNX.4.56.0310151035480.2144@bigblue.dev.mdolabs.com> <3F8D8F3A.5040506@nortelnetworks.com> <Pine.LNX.4.56.0310151133030.2144@bigblue.dev.mdolabs.com> <3F8DAA6B.7060609@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Friesen, Christopher [CAR:7Q28:EXCH] wrote:


> With 2.4.[18-20], the overall average goes up when the number of packets 
> goes up.  For 2.6.0-test6, it stays constant.

Okay, its official.  My brain isn't working.

The different kernels were tested on two different machines.  The one 
running 2.4 is *just* enough slower that the packets start to pile up 
and end up waiting in the socket buffer.  By slowing down the packet 
sending I get results that are invariant with the number of packets.

Sorry for the false alarm guys....

Chris




-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

