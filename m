Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262373AbVAQRiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbVAQRiu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 12:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbVAQRiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 12:38:50 -0500
Received: from fmr19.intel.com ([134.134.136.18]:47799 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S262444AbVAQRhd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 12:37:33 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] AC'97 Audio support for Intel ICH7 - 2.6.11-rc1
Date: Mon, 17 Jan 2005 09:37:17 -0800
Message-ID: <26CEE2C804D7BE47BC4686CDE863D0F502CE3079@orsmsx410>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] AC'97 Audio support for Intel ICH7 - 2.6.11-rc1
Thread-Index: AcT8iA4hckwkYwWMRM62S08uAUAvDAAMo8Eg
From: "Gaston, Jason D" <jason.d.gaston@intel.com>
To: "Takashi Iwai" <tiwai@suse.de>
Cc: <perex@suse.cz>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 17 Jan 2005 17:37:18.0814 (UTC) FILETIME=[31394FE0:01C4FCBB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ICH6 and ICH7 both have AC'97 modem DID's.

ICH6 AC'97 modem DID = 266d
ICH7 AC'97 modem DID = 27dd

Would you like me to create a patch adding both?

Thanks,

Jason



>-----Original Message-----
>From: Takashi Iwai [mailto:tiwai@suse.de]
>Sent: Monday, January 17, 2005 3:31 AM
>To: Gaston, Jason D
>Cc: perex@suse.cz; linux-kernel@vger.kernel.org
>Subject: Re: [PATCH] AC'97 Audio support for Intel ICH7 - 2.6.11-rc1
>
>At Fri, 14 Jan 2005 11:21:34 -0800,
>Jason Gaston wrote:
>>
>> This patch adds the ICH7 AC'97 DID the the intel8x0.c AC'97 audio driver.
> This patch was build against 2.6.11-rc1.
>> If acceptable, please apply.
>>
>> Thanks,
>>
>> Jason Gaston
>>
>> Signed-off-by:  Jason Gaston <Jason.d.gaston@intel.com>
>
>Thanks, I applied the patch to ALSA tree.
>
>Does ICH7 have an ac97 modem, too?
>If so, we miss the DID in the modem driver, too.
>(Well, the entry for ICH6 is also missing.  Anyone can confirm such a
> device?)
>
>
>Takashi
