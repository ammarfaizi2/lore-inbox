Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273108AbRJJIv7>; Wed, 10 Oct 2001 04:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275097AbRJJIvu>; Wed, 10 Oct 2001 04:51:50 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:8149 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S273108AbRJJIvd>; Wed, 10 Oct 2001 04:51:33 -0400
Message-ID: <3BC40C41.5040603@wipro.com>
Date: Wed, 10 Oct 2001 14:22:17 +0530
From: "BALBIR SINGH" <balbir.singh@wipro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Sticky/Key-Setable SysRq (resubmit)
In-Reply-To: <20011009105251.A20842@mueller.datastacks.com> <9pvd04$9sd$1@cesium.transmeta.com>
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

H. Peter Anvin wrote:

 >Followup to:  <20011009105251.A20842@mueller.datastacks.com>
 >By author:    Crutcher Dunnavant <crutcher@datastacks.com>
 >In newsgroup: linux.dev.kernel
 >
 >>Attached is the patch from last week which provides the sysrq system
 >>with the following:
 >>
 >>a toggleable 'sticky' flag in /proc, which makes the sysrq key work 
on bad
 >>keyboards, and through bad KVMs.
 >>
 >>the ability to set which key in /proc, which makes the sysrq key work on
 >>system _without_ a 'sysrq' key; like bad KVMs.
 >>
 >>I've gotten no tracktion on this in a week, so I'm resubmitting it.
 >>
 >
 >I think doing this through procfs might be reasonable, but a kernel
 >command line option would be absolutely mandatory.  If things are
 >crappy you might not get to the point of fidding with /proc.
 >
 >Also, I really think SysRq has nothing to do under "Kernel
 >Hacking/Kernel Debugging".  More than anything else it's a system
 >administration feature.
 >
 >	-hpa
 >

Also, when configuring the kernel you can decide not to have /proc 
mounted (although this is very rare), but it might happen, if somebody 
decided not to use it, so as suggested, I think a kernel command line 
option would be nice.

Balbir





--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

----------------------------------------------------------------------------------------------------------------------
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
