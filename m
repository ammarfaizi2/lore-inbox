Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279640AbRKHOX1>; Thu, 8 Nov 2001 09:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279717AbRKHOXR>; Thu, 8 Nov 2001 09:23:17 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:52131 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S279640AbRKHOXI>; Thu, 8 Nov 2001 09:23:08 -0500
Message-ID: <3BEA9305.60301@wipro.com>
Date: Thu, 08 Nov 2001 19:43:25 +0530
From: "BALBIR SINGH" <balbir.singh@wipro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: More dependencies on CONFIG_SMP
In-Reply-To: <21304.1005228713@ocs3.intra.ocs.com.au>
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

>
>
>
>There is a #define for atomic_dec_and_lock when compiling for UP.  I
>suspect that you have been bitten by the broken makefiles, otherwise
>everybody would be reporting problems with 2.4.14.  Before you send any
>more patches (and before your existing patches are used), please follow
>the steps in http://www.tux.org/lkml/#s8-8.
>
>If you still get problems after that, mail the error messages and your
>.config instead of sending patches to "fix" bugs which nobody else is
>seeing.  You should include the errors you are getting, otherwise we
>cannot tell if the patch makes sense or not.
>
Agreed and understood, that was my fault. I saw that dec_and_lock.c did not
compiled. So, I began to think that was the case.

Balbir


--------------InterScan_NT_MIME_Boundary
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

--------------InterScan_NT_MIME_Boundary--
