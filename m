Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318288AbSIBMrq>; Mon, 2 Sep 2002 08:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318290AbSIBMrq>; Mon, 2 Sep 2002 08:47:46 -0400
Received: from ns1.mscsoftware.com ([192.207.69.10]:41967 "EHLO
	draco.macsch.com") by vger.kernel.org with ESMTP id <S318288AbSIBMrp> convert rfc822-to-8bit;
	Mon, 2 Sep 2002 08:47:45 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Knoblauch <martin.knoblauch@mscsoftware.com>
Reply-To: martin.knoblauch@mscsoftware.com
Organization: MSC.Software GmbH
To: riel@conectiva.com.br
Subject: Re: Benchmarks for performance patches (-ck) for 2.4.19
Date: Mon, 2 Sep 2002 14:50:53 +0200
User-Agent: KMail/1.4.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209021450.53449.martin.knoblauch@mscsoftware.com>
X-AntiVirus: OK! AntiVir MailGate Version 2.0.1.2; AVE: 6.15.0.0; VDF: 6.15.0.6
	 at mailmuc has not found any known virus in this email.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I mean, besides making the kernel with as low latency as possible, 
what 
>> is bad about the responsiveness in the kernel? If there's any lag in 
>> responsiveness that i see it's always something X related, 
particularly 
>> Xfree86. 
>
>
>"low latency" != responsiveness 
>
>
>Any latency which is below the point the user can notice 
>is effectively zero, so whether the 10000 wakeups/minute 
>that the user doesn't notice are 2ms or 5ms don't really 
>matter. 

 absolugtely correct. My main grief wrt. responsiveness of desktop 
systems is when the VM decides to grow the cache at the cost of pushing 
parts of KDE into swap. As a result, "activating" windows that I 
haven't touched for some time takes noticeable delays, which ruins the 
interactiveness.

 My best setup for this is to have lots of memory and disable swap (and 
live with the consequences- eg. triggering the OOM killer).

 Admittedly, things seem to be much better now than six month ago.

Martin
-- 
Martin Knoblauch
Senior System Architect
MSC.software GmbH
Am Moosfeld 13
D-81829 Muenchen, Germany

e-mail: martin.knoblauch@mscsoftware.com
http://www.mscsoftware.com
Phone/Fax: +49-89-431987-189 / -7189
Mobile: +49-174-3069245

