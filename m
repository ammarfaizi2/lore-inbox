Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275696AbRIZXf4>; Wed, 26 Sep 2001 19:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275697AbRIZXfq>; Wed, 26 Sep 2001 19:35:46 -0400
Received: from [212.37.20.41] ([212.37.20.41]:47369 "HELO zaphod.nu")
	by vger.kernel.org with SMTP id <S275696AbRIZXf3>;
	Wed, 26 Sep 2001 19:35:29 -0400
From: =?us-ascii?Q?Peter_Sandstrom?= <peter@zaphod.nu>
To: "Robert Cantu" <robert@tux.cs.ou.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Question: Etherenet Link Detection
Date: Fri, 28 Sep 2001 01:36:07 +0200
Message-ID: <CIEJKOKMAIAHDBBLFGFFEEOPCGAA.peter@zaphod.nu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20010926174116.A7544@tux.cs.ou.edu>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know for sure that the Intel 82559 Fast Ethernet embedded controller 
has a register where it's possible to read out if the link led is active
or not. It seems quite likely that this would be available on other
controllers as well.

Is there any functionality in the current kernel that enables a userland
program to read this? I mostly turn my machines on and and let them do
their thing until the hardware fails :)

/Peter

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Robert Cantu
Sent: den 26 september 2001 23:41
To: linux-kernel@vger.kernel.org
Subject: Question: Etherenet Link Detection


Is there a method of detecting the link status of an ethernet NIC? If not,
is it feasible? And if it is, then would it be something in each driver,  
or on a level above the driver, thereby available to all drivers? I figure
the list is the best place to ask this, although it might be a moot point.
                                                                
Example: Have a cable modem hooked into a computer's NIC. Cable service   
goes out, link light on back of NIC goes out. A hypothetical program says 
that the link is gone via some hook in /proc somewhere.

Is this a worthwhile endeavor, if possible?

Thanks in advance,
Robert

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


