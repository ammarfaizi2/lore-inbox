Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316673AbSFKD3j>; Mon, 10 Jun 2002 23:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316682AbSFKD3j>; Mon, 10 Jun 2002 23:29:39 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:43943 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S316673AbSFKD3g>; Mon, 10 Jun 2002 23:29:36 -0400
From: "BALBIR SINGH" <balbir.singh@wipro.com>
To: "'Joel Jaeggli'" <joelja@darkwing.uoregon.edu>,
        "'Bill Davidsen'" <davidsen@tmr.com>
Cc: "'Olivier Galibert'" <galibert@pobox.com>, <linux-kernel@vger.kernel.org>
Subject: RE: MTU discovery
Date: Tue, 11 Jun 2002 09:01:45 +0530
Message-ID: <039d01c210f8$83fa54b0$290806c0@wipro.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-850d92bd-7606-4120-a557-7bc76c3cf887"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <Pine.LNX.4.44.0206101453270.767-100000@twin.uoregon.edu>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-850d92bd-7606-4120-a557-7bc76c3cf887
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Actually not, the Intel driver/card supports a size of

look into e1000_mac.h

#define MAX_JUMBO_FRAME_SIZE         0x3F00 (which is  16128).

The bottom line is 9000 is not the limit, it is
just the beginning of jumbo frame sizes.

Balbir

|-----Original Message-----
|From: linux-kernel-owner@vger.kernel.org 
|[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Joel Jaeggli
|Sent: Tuesday, June 11, 2002 3:32 AM
|To: Bill Davidsen
|Cc: Olivier Galibert; linux-kernel@vger.kernel.org
|Subject: Re: MTU discovery
|
|
|
|9000 is the limit on gigabit ethernet, other media type have different 
|maximum frame sizes (ie 4470 on fddi, 9216 on pos oc12 interfaces). 
|


------=_NextPartTM-000-850d92bd-7606-4120-a557-7bc76c3cf887
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

**************************Disclaimer************************************

Information contained in this E-MAIL being proprietary to Wipro Limited is 
'privileged' and 'confidential' and intended for use only by the individual
 or entity to which it is addressed. You are notified that any use, copying 
or dissemination of the information contained in the E-MAIL in any manner 
whatsoever is strictly prohibited.

***************************************************************************

------=_NextPartTM-000-850d92bd-7606-4120-a557-7bc76c3cf887--
