Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVARSST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVARSST (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 13:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbVARSSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 13:18:18 -0500
Received: from fmr18.intel.com ([134.134.136.17]:8902 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261365AbVARSR7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 13:17:59 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] AC'97 Audio support for Intel ICH7 - 2.6.11-rc1
Date: Tue, 18 Jan 2005 10:17:33 -0800
Message-ID: <26CEE2C804D7BE47BC4686CDE863D0F502D1C2A8@orsmsx410>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] AC'97 Audio support for Intel ICH7 - 2.6.11-rc1
Thread-Index: AcT9Pb1C+cIfSBt3T0i+i64h+O4R0QATBA0g
From: "Gaston, Jason D" <jason.d.gaston@intel.com>
To: "Takashi Iwai" <tiwai@suse.de>
Cc: <perex@suse.cz>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 Jan 2005 18:17:34.0800 (UTC) FILETIME=[FBAD4500:01C4FD89]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have never had an opportunity to test AC'97 modems on ICH6 or ICH7.

Sorry,

Jason


>-----Original Message-----
>From: Takashi Iwai [mailto:tiwai@suse.de]
>Sent: Tuesday, January 18, 2005 1:12 AM
>To: Gaston, Jason D
>Cc: perex@suse.cz; linux-kernel@vger.kernel.org
>Subject: Re: [PATCH] AC'97 Audio support for Intel ICH7 - 2.6.11-rc1
>
>At Mon, 17 Jan 2005 09:37:17 -0800,
>Gaston, Jason D wrote:
>>
>> ICH6 and ICH7 both have AC'97 modem DID's.
>>
>> ICH6 AC'97 modem DID = 266d
>> ICH7 AC'97 modem DID = 27dd
>>
>> Would you like me to create a patch adding both?
>
>Not necessary, the patch would be easy to me, too :)
>
>But, I'd like to confirm that the driver really works on these
>chipsets before adding the IDs.
>
>
>thanks,
>
>Takashi
>
>> Thanks,
>>
>> Jason
>>
>>
>>
>> >-----Original Message-----
>> >From: Takashi Iwai [mailto:tiwai@suse.de]
>> >Sent: Monday, January 17, 2005 3:31 AM
>> >To: Gaston, Jason D
>> >Cc: perex@suse.cz; linux-kernel@vger.kernel.org
>> >Subject: Re: [PATCH] AC'97 Audio support for Intel ICH7 - 2.6.11-rc1
>> >
>> >At Fri, 14 Jan 2005 11:21:34 -0800,
>> >Jason Gaston wrote:
>> >>
>> >> This patch adds the ICH7 AC'97 DID the the intel8x0.c AC'97 audio
>driver.
>> > This patch was build against 2.6.11-rc1.
>> >> If acceptable, please apply.
>> >>
>> >> Thanks,
>> >>
>> >> Jason Gaston
>> >>
>> >> Signed-off-by:  Jason Gaston <Jason.d.gaston@intel.com>
>> >
>> >Thanks, I applied the patch to ALSA tree.
>> >
>> >Does ICH7 have an ac97 modem, too?
>> >If so, we miss the DID in the modem driver, too.
>> >(Well, the entry for ICH6 is also missing.  Anyone can confirm such a
>> > device?)
>> >
>> >
>> >Takashi
>>
