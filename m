Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129235AbRAYQgj>; Thu, 25 Jan 2001 11:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129169AbRAYQg3>; Thu, 25 Jan 2001 11:36:29 -0500
Received: from mcdc-us-smtp4.cdc.gov ([198.246.97.20]:44815 "EHLO
	mcdc-us-smtp4.cdc.gov") by vger.kernel.org with ESMTP
	id <S129101AbRAYQgX>; Thu, 25 Jan 2001 11:36:23 -0500
Message-ID: <B7F9A3E3FDDDD11185510000F8BDBBF2049E8062@mcdc-atl-5.cdc.gov>
X-Sybari-Space: 00000000 00000000 00000000
From: Heitzso <xxh1@cdc.gov>
To: "'Venkatesh Ramamurthy'" <Venkateshr@ami.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: megaraid 1.14e works with updated firmware
Date: Thu, 25 Jan 2001 11:35:19 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Venkatesh,

Thanks, I assume you're modifying your megaraid
code to note firmware upgrade necessity to the user
for this case.

Trick was Dell download site didn't route to the new 
firmware when selecting on the box and RH Linux.
I don't know what magic selection would have popped
up the driver.  Both Venkatesh and Dells' Linux
support person flagged the need for the new driver.
Thanks again.

I haven't tried going back and setting up and
booting any of the other kernels again that 
failed before (i.e. 2.2.16 or 2.2.18).  I'm running
peacefully with 2.4.1pre10 and the 1.14e megaraid
driver code.

If it's of interest to anyone I could try booting
one of my kernels that's still running the older
megaraid driver (that ran fine with older firmware
i.e. 2.2.13 or 2.4.0). Or, more of a hassle, but
could download the 2.2.18 again and rebuild and
try that.

Heitzso
xxh1@cdc.gov

-----Original Message-----
From: Venkatesh Ramamurthy [mailto:Venkateshr@ami.com]
Sent: Thursday, January 25, 2001 10:35 AM
To: 'Heitzso'
Subject: RE: megaraid 1.14e still broken


upgrading your firmware version will solve your problem. 
http://support.dell.com/us/en/filelib/download/index.asp?fileid=R15116

> -----Original Message-----
> From:	Heitzso [SMTP:xxh1@cdc.gov]
> Sent:	Thursday, January 25, 2001 10:17 AM
> To:	'Venkatesh Ramamurthy'
> Subject:	RE: megaraid 1.14e still broken
> 
> just double checked Dell's site and
> they don't list any megaraid drivers
> post 2.2.15 kernel for PowerEdge 2300
> servers
> 
> also no firmware updates listed
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
