Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289193AbSAGNNV>; Mon, 7 Jan 2002 08:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289185AbSAGNNC>; Mon, 7 Jan 2002 08:13:02 -0500
Received: from wiproecmx1.wipro.com ([164.164.31.5]:2214 "EHLO
	wiproecmx1.wipro.com") by vger.kernel.org with ESMTP
	id <S289184AbSAGNMm>; Mon, 7 Jan 2002 08:12:42 -0500
Message-ID: <002101c1977e$2e0f9090$4e05720a@M3HOM103042>
From: "Venkata Rajesh Velamakanni" <rajesh.venkata@wipro.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <001b01c1976f$d11da6f0$4e05720a@M3HOM103042>
Subject: Re: Faced a problem with rtnetlink socket ( RTM_DELLINK)
Date: Mon, 7 Jan 2002 18:51:13 +0530
Organization: Wipro Ltd.
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-9668d87a-0367-11d6-a941-00b0d0d06be8"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-9668d87a-0367-11d6-a941-00b0d0d06be8
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Please ignore the previous mail. I came to know that
in both cases kernel sends  RTM_NEWLINK and one can
differentiate it using the flags ( IFF_RUNNING).

Thanks,
Rajesh.
----- Original Message ----- 
From: "Venkata Rajesh Velamakanni" <rajesh.venkata@wipro.com>
To: <linux-kernel@vger.kernel.org>
Sent: Monday, January 07, 2002 5:08 PM
Subject: Faced a problem with rtnetlink socket ( RTM_DELLINK)


Hello All,

I am facing a problem in using rtnetlink sockets and thought that 
this mailing list would be the better to place to clarify.  
Can anyone calrify my query.  

When I tried deleting an interface, I have received message
 RTM_NEWLINK (instead of  RTM_DELLINK) from kernel.

I have executed the attached program and did "/sbin/ifdown eth0"..
and my program received a messsage RTM_NEWLINK from kernel
instead of RTM_DELLINK.

When I  tried adding the interface "/sbin/ifup eth0".. it works fine 
and received RTM_NEWLINK.

I would like to know whether anyone has faced this problem or
am I missing something in my program.

Thanks,
Rajesh.













------=_NextPartTM-000-9668d87a-0367-11d6-a941-00b0d0d06be8
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

-----------------------------------------------------------------------------------------------------------------------
Information transmitted by this E-MAIL is proprietary to Wipro and/or its Customers and
is intended for use only by the individual or entity to which it is
addressed, and may contain information that is privileged, confidential or
exempt from disclosure under applicable law. If you are not the intended
recipient or it appears that this mail has been forwarded to you without
proper authority, you are notified that any use or dissemination of this
information in any manner is strictly prohibited. In such cases, please
notify us immediately at mailto:mailadmin@wipro.com and delete this mail
from your records.
------------------------------------------------------------------------------------------------------------------------

------=_NextPartTM-000-9668d87a-0367-11d6-a941-00b0d0d06be8--
