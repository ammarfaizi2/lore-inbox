Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266123AbRGLMvc>; Thu, 12 Jul 2001 08:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266129AbRGLMvW>; Thu, 12 Jul 2001 08:51:22 -0400
Received: from thumper.research.telcordia.com ([128.96.41.1]:58320 "EHLO
	thumper.research.telcordia.com") by vger.kernel.org with ESMTP
	id <S266123AbRGLMvJ>; Thu, 12 Jul 2001 08:51:09 -0400
From: "Jatin Shah" <jatin.shah@yale.edu>
To: "William Scott Lockwood III" <scottlockwood@hotmail.com>,
        <jatin.shah@yale.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Resource busy
Date: Thu, 12 Jul 2001 08:50:53 -0400
Message-ID: <NFBBKICLIMNAAAFFEFLCEEGKCAAA.jatin.shah@yale.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <OE248oNEGlPN7L7peSs000032a5@hotmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nope, there is no process which has the camera. What has happened is that
camera is opened and the process crashes. So now the camera has to be closed
somehow.

I tried all the things you suggested. Did not work.


Jatin

|-----Original Message-----
|From: William Scott Lockwood III [mailto:thatlinuxguy@hotmail.com]
|Sent: Thursday, July 12, 2001 8:26 AM
|To: jatin.shah@yale.edu
|Cc: linux-kernel@vger.kernel.org
|Subject: Re: Resource busy
|
|
|What does ps aux show?  Is there still a process that has the camera?  Can
|you kill -9 <pid> to get rid of that process, and does the camera then
|unlock?
|
|----- Original Message -----
|From: "Jatin Shah" <jatin_shah100@hotmail.com>
|To: <linux-kernel@vger.kernel.org>
|Sent: Wednesday, July 11, 2001 10:57 PM
|Subject: Resource busy
|
|
|> Hi,
|> I have an application that uses an USB camera. This app is bit buggy and
|> when it crashes (segmentation fault) it locks the devices so that the app
|> always gets the message "Device or Resource Busy"(Thats error
|EBUSY). Note
|> that app, mmaps device to memory.
|>
|>         Now that app has crashed how do I release the device? rmmod on
|> camera driver (or uhci) does not work.
|>
|> Jatin
|> PS: Please cc me the response.
|> _________________________________________________________________
|> Get your FREE download of MSN Explorer at http://explorer.msn.com
|>
|> -
|> To unsubscribe from this list: send the line "unsubscribe
|linux-kernel" in
|> the body of a message to majordomo@vger.kernel.org
|> More majordomo info at  http://vger.kernel.org/majordomo-info.html
|> Please read the FAQ at  http://www.tux.org/lkml/
|>
|

