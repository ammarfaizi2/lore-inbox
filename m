Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284052AbRLELL2>; Wed, 5 Dec 2001 06:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284053AbRLELLS>; Wed, 5 Dec 2001 06:11:18 -0500
Received: from wiprom2mx2.wipro.com ([203.197.164.42]:27877 "EHLO
	wiprom2mx2.wipro.com") by vger.kernel.org with ESMTP
	id <S284052AbRLELLF>; Wed, 5 Dec 2001 06:11:05 -0500
From: "Jyotheeswara Rao Kurma" <jyotheeswara.rao@wipro.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Message-ID: <3ab3637593.375933ab36@wipro.com>
Date: Wed, 05 Dec 2001 16:10:58 +0500
X-Mailer: Netscape Webmail
MIME-Version: 1.0
Content-Language: en
Subject: Re: netlink socket help
X-Accept-Language: en
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-0709b30a-e96f-11d5-a216-0000e22173f5"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-0709b30a-e96f-11d5-a216-0000e22173f5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


> > How to get kernel route table ( not cache ) into user space , using
> > netlink sockets, i tried with NLM_F_ROOT option. but it is 
> giving the 
> > route cache . 
> 
> Don't set the RTM_F_CLONED flag in the request.
> 

  But still getting entries more than what route/netstat  command is 
  showing.  Any thing else ? 

> -Andi
> 


------=_NextPartTM-000-0709b30a-e96f-11d5-a216-0000e22173f5
Content-Type: text/plain;
	name="InterScan_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="InterScan_Disclaimer.txt"

-------------------------------------------------------------------------------------------------------------------------
Information transmitted by this E-MAIL is proprietary to Wipro and/or its Customers and
is intended for use only by the individual or entity to which it is
addressed, and may contain information that is privileged, confidential or
exempt from disclosure under applicable law. If you are not the intended
recipient or it appears that this mail has been forwarded to you without
proper authority, you are notified that any use or dissemination of this
information in any manner is strictly prohibited. In such cases, please
notify us immediately at mailto:mailadmin@wipro.com and delete this mail
from your records.
----------------------------------------------------------------------------------------------------------------------

------=_NextPartTM-000-0709b30a-e96f-11d5-a216-0000e22173f5--
