Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266771AbTBCP3D>; Mon, 3 Feb 2003 10:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266795AbTBCP3C>; Mon, 3 Feb 2003 10:29:02 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:407 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S266771AbTBCP2H>; Mon, 3 Feb 2003 10:28:07 -0500
Message-ID: <3E3E8CAC.7010807@nortelnetworks.com>
Date: Mon, 03 Feb 2003 10:37:16 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
Cc: bert hubert <ahu@ds9a.nl>, Ben Greear <greearb@candelatech.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: problems achieving decent throughput with latency.
References: <3E3CCADA.6080308@candelatech.com> 	<20030202114838.GA16831@outpost.ds9a.nl> <1044249293.19078.1.camel@rth.ninka.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> TCP can only send into a pipe as fast as it can see the
> ACKs coming back.  That is how TCP clocks its sending rate,
> and latency thus affects that.

Wouldn't you just need larger windows?  The problem is latency, not 
bandwidth.

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

