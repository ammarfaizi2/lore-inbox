Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266097AbRGLMWq>; Thu, 12 Jul 2001 08:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266103AbRGLMWg>; Thu, 12 Jul 2001 08:22:36 -0400
Received: from oe24.law3.hotmail.com ([209.185.240.17]:50951 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S266097AbRGLMWW>;
	Thu, 12 Jul 2001 08:22:22 -0400
X-Originating-IP: [4.16.58.17]
Reply-To: "William Scott Lockwood III" <scottlockwood@hotmail.com>
From: "William Scott Lockwood III" <thatlinuxguy@hotmail.com>
To: <jatin.shah@yale.edu>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <F123WsJ4X0q1y9v2N3t00013f69@hotmail.com>
Subject: Re: Resource busy
Date: Thu, 12 Jul 2001 07:26:18 -0500
MIME-Version: 1.0
Content-Type: text/plain;	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Message-ID: <OE248oNEGlPN7L7peSs000032a5@hotmail.com>
X-OriginalArrivalTime: 12 Jul 2001 12:22:19.0544 (UTC) FILETIME=[4B90D180:01C10ACD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What does ps aux show?  Is there still a process that has the camera?  Can
you kill -9 <pid> to get rid of that process, and does the camera then
unlock?

----- Original Message -----
From: "Jatin Shah" <jatin_shah100@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Sent: Wednesday, July 11, 2001 10:57 PM
Subject: Resource busy


> Hi,
> I have an application that uses an USB camera. This app is bit buggy and
> when it crashes (segmentation fault) it locks the devices so that the app
> always gets the message "Device or Resource Busy"(Thats error EBUSY). Note
> that app, mmaps device to memory.
>
>         Now that app has crashed how do I release the device? rmmod on
> camera driver (or uhci) does not work.
>
> Jatin
> PS: Please cc me the response.
> _________________________________________________________________
> Get your FREE download of MSN Explorer at http://explorer.msn.com
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
